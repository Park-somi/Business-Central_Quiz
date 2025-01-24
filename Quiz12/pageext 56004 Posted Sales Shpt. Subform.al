pageextension 56004 PostedSalesShptSubform extends "Posted Sales Shpt. Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Customer Contact"; Rec."DXK Customer Contact")
            {
                ApplicationArea = All;
            }
            field("Customer Contact Name"; Rec."DXK Customer Contact Name")
            {
                ApplicationArea = All;
            }
        }
    }

}