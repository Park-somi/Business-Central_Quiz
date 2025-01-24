tableextension 56007 SalesInvoiceHeader extends "Sales Invoice Header"
{
    fields
    {
        field(80000; "DXK Customer Contact"; Code[10])
        {
            Caption = 'Customer Contact';
            TableRelation = "DXK Customer Contact".Code;
        }
        field(80001; "DXK Customer Contact Name"; Text[30])
        {
            Caption = 'Customer Contact Name';
        }
    }
}