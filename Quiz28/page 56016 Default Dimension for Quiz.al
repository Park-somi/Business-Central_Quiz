page 56016 "Default Dimension for Quiz"
{
    Caption = 'Default Dimension for Quiz';
    PageType = List;
    SourceTable = "Default Dimension for Quiz";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Dimension Code"; Rec."Dimension Code")
                {
                    ApplicationArea = All;

                    // 중복된 Dimension Code 입력 불가능
                    trigger OnValidate()
                    begin
                        Rec.Reset();
                        Rec.SetRange("Quiz No.", SelectedQuizNo);
                        Rec.SetRange("Dimension Code", Rec."Dimension Code");
                        if Rec.FindFirst() then
                            Error('This Dimension Code is already used.');
                    end;
                }
                field("Dimension Value Code"; Rec."Dimension Value Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        // Quiz No.에 선택된 Quiz No.를 넣어줌
        Rec.Init();
        Rec."Quiz No." := SelectedQuizNo;
    end;

    trigger OnOpenPage()
    begin
        // Quiz No.가 선택된 Quiz No.와 같은 경우의 Dimension Code와 Dimension Value Code를 보여줌
        Rec.Reset();
        Rec.SetRange("Quiz No.", SelectedQuizNo);
        CurrPage.Update(false);
    end;

    procedure SetSelectedQuizNo(QuizNo: Code[20])
    begin
        SelectedQuizNo := QuizNo;
    end;

    var
        SelectedQuizNo: Code[20];
}