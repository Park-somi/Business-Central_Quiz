tableextension 56005 SalesInvoiceLine extends "Sales Invoice Line"
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