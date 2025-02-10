page 56000 "DXK Customer Contact List"
{
    Caption = 'Customer Contact List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DXK Customer Contact";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code) { ApplicationArea = Basic; }
                field("Name"; Rec.Name) { ApplicationArea = Basic; }
            }
        }

        // 데이터를 저장하는 페이지에는 기본적으로 아래 2개의 factbox를 구성
        area(FactBoxes)
        {
            systempart(Control900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = true;
            }
            systempart(Control905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }
    }
}