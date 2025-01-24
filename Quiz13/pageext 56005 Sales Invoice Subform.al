pageextension 56005 SalesInvoiceSubform extends "Sales Invoice Subform"
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