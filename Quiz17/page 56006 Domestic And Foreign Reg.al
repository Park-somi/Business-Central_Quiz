page 56006 "Domestic And Foreign Reg"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Domestic And Foreign Reg";
    Caption = 'Domestic and foreign registration';
    CardPageId = "Domestic And Foreign Reg Card";

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
    }
}