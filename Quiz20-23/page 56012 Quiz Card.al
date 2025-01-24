page 56012 "Quiz Card"
{
    PageType = Card;
    SourceTable = "Quiz";

    layout
    {
        area(Content)
        {
            group(Group)
            {
                field("Quiz No."; Rec."Quiz No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Quiz Name"; Rec."Quiz Name")
                {
                    ApplicationArea = All;
                    Editable = IsEditQuizName;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Dimension Set Id"; Rec."Dimension Set Id")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            part(Comment; "Quiz Comment Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("Quiz No.");
                SubPageView = sorting("Document No.", "Comment No.");
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            actionref(Change; "Change Status") { }
            actionref(Copy; "Copy Quiz") { }
            actionref(DefaultDimension; "Default Dimension") { }
        }
        area(Processing)
        {
            action("Change Status")
            {
                Caption = 'Change Status';
                ApplicationArea = All;
                Image = Edit;

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Open then begin
                        Rec.Status := Rec.Status::Released;
                        IsEditQuizName := false;
                    end else begin
                        Rec.Status := Rec.Status::Open;
                        IsEditQuizName := true;
                    end;
                end;
            }
            action("Copy Quiz")
            {
                Caption = 'Copy Quiz';
                ApplicationArea = All;
                Image = Copy;

                trigger OnAction()
                var
                    QuizRec: Record Quiz;
                    CopyQuizReport: Report "Copy Quiz";
                    Result: Action;
                begin
                    CurrPage.SetSelectionFilter(QuizRec); // 선택된 레코드를 가져옴

                    if QuizRec.FindFirst() then begin
                        CopyQuizReport.SetSelectedQuizNo(QuizRec."Quiz No.");
                        CopyQuizReport.RunModal();
                    end;
                end;
            }

            action("Default Dimension")
            {
                Caption = 'Default Dimension';
                ApplicationArea = All;
                Image = Dimensions;

                trigger OnAction()
                var
                    DefaultDimensionPage: Page "Default Dimension for Quiz";
                    DefaultDimensionTable: Record "Default Dimension for Quiz";
                    QuizRec: Record Quiz;
                    QuizList: Page "Quiz List";
                    DimMgt: Codeunit "DimensionManagement";
                    TempDimSetEntry: Record "Dimension Set Entry" temporary;
                    DimValue: Record "Dimension Value";
                begin
                    CurrPage.SetSelectionFilter(QuizRec);

                    if QuizRec.FindFirst() then begin
                        DefaultDimensionPage.SetSelectedQuizNo(QuizRec."Quiz No.");
                        if DefaultDimensionPage.RunModal() = Action::OK then begin
                            DefaultDimensionTable.Reset();
                            DefaultDimensionTable.SetRange("Quiz No.", QuizRec."Quiz No.");
                            if DefaultDimensionTable.FindSet() then
                                repeat
                                    TempDimSetEntry.Init();
                                    TempDimSetEntry."Dimension Code" := DefaultDimensionTable."Dimension Code";
                                    TempDimSetEntry."Dimension Value Code" := DefaultDimensionTable."Dimension Value Code";
                                    DimValue.Get(DefaultDimensionTable."Dimension Code", DefaultDimensionTable."Dimension Value Code");
                                    TempDimSetEntry."Dimension Value ID" := DimValue."Dimension Value ID";
                                    TempDimSetEntry.Insert();
                                until DefaultDimensionTable.Next() = 0;

                            QuizRec."Dimension Set Id" := DimMgt.GetDimensionSetID(TempDimSetEntry);
                            QuizRec.Modify();
                        end;
                    end;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        QuizSetup: Record "Quiz Setup";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
    begin
        // Quiz Setup에서 Quiz Nos. 값 가져오기
        if QuizSetup.Get() then begin
            Rec.Init();
            Rec."Quiz No." := NoSeriesMgt.GetNextNo(QuizSetup."Quiz Nos.", WORKDATE, true); // Quiz Nos. 번호 시리즈 사용
        end else
            Error('Quiz Setup 레코드가 존재하지 않습니다. 관리자를 확인하세요.');
    end;

    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::Open then
            IsEditQuizName := true
        else
            IsEditQuizName := false;
    end;

    var
        IsEditQuizName: Boolean;
}