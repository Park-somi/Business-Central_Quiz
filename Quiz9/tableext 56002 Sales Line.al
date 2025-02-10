tableextension 56002 SalesLine extends "Sales Line"
{
    fields
    {
        // Quiz 9
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                SalesHeader: Record "Sales Header";
            begin
                if SalesHeader.Get("Document Type", "Document No.") then
                    if SalesHeader."DXK Customer Contact" <> '' then begin
                        "DXK Customer Contact" := SalesHeader."DXK Customer Contact";
                        "DXK Customer Contact Name" := SalesHeader."DXK Customer Contact Name";
                    end else begin
                        "DXK Customer Contact" := '';
                        "DXK Customer Contact Name" := '';
                    end;
            end;
        }
        field(56000; "DXK Customer Contact"; Code[10])
        {
            Caption = 'Customer Contact';
            TableRelation = "DXK Customer Contact".Code;

            trigger OnValidate()
            var
                SalesHeader: Record "Sales Header";
                DXKCustomerContact: Record "DXK Customer Contact";
            begin
                // Quiz 10(Codeunit으로 대체)
                // if SalesHeader.Get("Document Type", "Document No.") then begin
                //     if SalesHeader.Status = SalesHeader.Status::Released then
                //         Error('Release 상태이므로 수정할 수 없습니다.');
                // end;

                // Quiz 9 피드백
                if DXKCustomerContact.Get("DXK Customer Contact") then begin
                    "DXK Customer Contact Name" := DXKCustomerContact.Name;
                end else
                    "DXK Customer Contact Name" := '';

            end;
        }
        field(56001; "DXK Customer Contact Name"; Text[30])
        {
            Caption = 'Customer Contact Name';
            Editable = false;
        }
    }
}