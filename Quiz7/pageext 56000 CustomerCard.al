pageextension 56000 CustomerCard extends "Customer Card"
{
    layout
    {
        addafter("Disable Search by Name")
        {
            field("Customer Contact"; Rec."DXK Customer Contact")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Customer Contact Name"; Rec."DXK Customer Contact Name")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

}