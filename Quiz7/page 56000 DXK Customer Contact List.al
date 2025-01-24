page 56000 "DXK Customer Contact List"
{
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
    }
}