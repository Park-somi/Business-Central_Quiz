page 56012 "Quiz Card"
{
    Caption = 'Quiz Card';
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
                    AssistEdit = true;
                }
                field("Quiz Name"; Rec."Quiz Name")
                {
                    ApplicationArea = All;
                    Editable = (Rec.Status = Rec.Status::Open);
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
                Editable = (Rec.Status = Rec.Status::Open); // editable은 이렇게도 가능
            }
        }

        //데이터를 저장하는 페이지에는 기본적으로 아래 2개의 factbox 구성함.
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = true;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
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
                Image = Change;

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Open then begin
                        Rec.Status := Rec.Status::Released;
                        // IsEditQuizName := false;
                    end else begin
                        Rec.Status := Rec.Status::Open;
                        // IsEditQuizName := true;
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

                    CopyQuizReport.SetSelectedQuizNo(QuizRec."Quiz No.");
                    CopyQuizReport.RunModal();
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

                    if QuizRec.Count() > 1 then
                        Error('You must select one line for dimension setup');

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
}