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
}