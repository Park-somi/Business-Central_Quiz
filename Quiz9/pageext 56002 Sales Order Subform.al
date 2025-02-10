pageextension 56002 SalesOrderSubform extends "Sales Order Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Customer Contact"; Rec."DXK Customer Contact")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
            field("Customer Contact Name"; Rec."DXK Customer Contact Name")
            {
                ApplicationArea = All;
            }
        }
    }

}