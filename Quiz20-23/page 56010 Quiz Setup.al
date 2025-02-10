page 56010 "Quiz Setup"
{
    PageType = Card;
    ApplicationArea = Basic, Suite;
    UsageCategory = Administration;
    SourceTable = "Quiz Setup";
    Caption = 'Quiz Setup';
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group("Number Series")
            {
                field("Quiz Nos."; Rec."Quiz Nos.")
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

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}