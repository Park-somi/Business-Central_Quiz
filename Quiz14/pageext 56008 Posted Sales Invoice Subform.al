pageextension 56008 MyExtension extends "Posted Sales Invoice Subform"
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