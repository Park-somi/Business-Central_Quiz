page 56011 "Quiz List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Quiz;
    Caption = 'Quiz List';
    CardPageId = "Quiz Card";
    Editable = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Quiz No."; Rec."Quiz No.")
                {
                    ApplicationArea = All;
                }
                field("Quiz Name"; Rec."Quiz Name")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Dimension Set Id"; Rec."Dimension Set Id")
                {
                    ApplicationArea = All;
                }
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
                var
                    QuizRec: Record Quiz;
                begin
                    CurrPage.SetSelectionFilter(QuizRec); // 선택된 레코드를 가져옴

                    if QuizRec.FindSet() then
                        repeat
                            if QuizRec.Status = QuizRec.Status::Open then
                                QuizRec.Status := QuizRec.Status::Released
                            else
                                QuizRec.Status := QuizRec.Status::Open;

                            QuizRec.Modify();
                        until QuizRec.Next() = 0;
                    CurrPage.Update(false);
                end;
            }

            action("Copy Quiz")
            {
                Caption = 'Copy Quiz';
                ApplicationArea = All;
                Image = Copy;

                // 선택된 레코드의 번호를 Copy Quiz에 전달
                trigger OnAction()
                var
                    QuizRec: Record Quiz;
                    CopyQuizReport: Report "Copy Quiz";
                begin
                    CurrPage.SetSelectionFilter(QuizRec); // 선택된 레코드를 가져옴

                    if QuizRec.Count() > 1 then
                        Error('You must select one line for copying');

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

                    if QuizRec.Count() > 1 then
                        Error('You must select one line for dimension setup');

                    if QuizRec.FindFirst() then begin
                        // Default Dimension 페이지에 선택된 Quiz No. 설정
                        DefaultDimensionPage.SetSelectedQuizNo(QuizRec."Quiz No.");
                        if DefaultDimensionPage.RunModal() = Action::OK then begin
                            // Default Dimension 테이블에서 해당 Quiz의 Dimension 정보 조회
                            DefaultDimensionTable.Reset();
                            DefaultDimensionTable.SetRange("Quiz No.", QuizRec."Quiz No.");
                            if DefaultDimensionTable.FindSet() then
                                repeat
                                    // 임시 Dimension Set Entry 레코드 생성
                                    TempDimSetEntry.Init();
                                    TempDimSetEntry."Dimension Code" := DefaultDimensionTable."Dimension Code";
                                    TempDimSetEntry."Dimension Value Code" := DefaultDimensionTable."Dimension Value Code";
                                    // Dimension Value ID 가져오기
                                    DimValue.Get(DefaultDimensionTable."Dimension Code", DefaultDimensionTable."Dimension Value Code");
                                    TempDimSetEntry."Dimension Value ID" := DimValue."Dimension Value ID";
                                    TempDimSetEntry.Insert();
                                until DefaultDimensionTable.Next() = 0;

                            // Quiz 레코드에 Dimension Set ID 설정
                            QuizRec."Dimension Set Id" := DimMgt.GetDimensionSetID(TempDimSetEntry);
                            QuizRec.Modify();
                        end;
                    end;
                end;
            }
        }
    }
}