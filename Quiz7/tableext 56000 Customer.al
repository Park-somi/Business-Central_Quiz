tableextension 56000 Customer extends "Customer"
{
    fields
    {
        field(56000; "DXK Customer Contact"; Code[10])
        {
            Caption = 'Customer Contact';
            TableRelation = "DXK Customer Contact".Code;

            trigger OnValidate()
            var
                DXKCustomerContact: Record "DXK Customer Contact";
            begin
                if DXKCustomerContact.Get("DXK Customer Contact") then
                    "DXK Customer Contact Name" := DXKCustomerContact.Name
                else
                    "DXK Customer Contact Name" := ''
            end;
        }
        field(56001; "DXK Customer Contact Name"; Text[30])
        {
            Caption = 'Customer Contact Name';
        }
    }
}