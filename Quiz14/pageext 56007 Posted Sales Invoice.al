pageextension 56007 PostedSalesInvoice extends "Posted Sales Invoice"
{
    layout
    {
        addafter(Cancelled)
        {
            field("Customer Contact"; Rec."DXK Customer Contact")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Customer Contact Name"; Rec."DXK Customer Contact Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}