page 56006 "Domestic And Foreign Reg"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Domestic And Foreign Reg";
    Caption = 'Domestic and foreign registration';
    CardPageId = "Domestic And Foreign Reg Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Nationality Type"; Rec."Nationality Type")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Country"; Rec.Country)
                {
                    ApplicationArea = All;
                }
                field("Domestic Registration No."; Rec."Domestic Registration No.")
                {
                    ApplicationArea = All;
                }
                field("Foreigner Registration No."; Rec."Foreigner Registration No.")
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
}