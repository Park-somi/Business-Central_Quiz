tableextension 56001 SalesHeader extends "Sales Header"
{
    fields
    {
        // Quiz 8
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                Customer: Record Customer;
            begin
                if Customer.Get("Sell-to Customer No.") then begin
                    if Customer."DXK Customer Contact" <> '' then begin
                        "DXK Customer Contact" := Customer."DXK Customer Contact";
                        "DXK Customer Contact Name" := Customer."DXK Customer Contact Name";
                    end else begin
                        "DXK Customer Contact" := '';
                        "DXK Customer Contact Name" := '';
                    end;
                end;
            end;
        }
        field(56000; "DXK Customer Contact"; Code[10])
        {
            Caption = 'Customer Contact';
            TableRelation = "DXK Customer Contact".Code;

            trigger OnValidate()
            var
                DXKCustomerContact: Record "DXK Customer Contact";
                SalesLine: Record "Sales Line";
                SalesHeader: Record "Sales Header";
            begin
                // Quiz 10(피드백)
                if Rec.Status = Rec.Status::Released then begin
                    Error('Release 상태이므로 수정할 수 없습니다.');
                end;

                // Quiz 8
                if DXKCustomerContact.Get("DXK Customer Contact") then begin
                    "DXK Customer Contact Name" := DXKCustomerContact.Name;
                end else
                    "DXK Customer Contact Name" := '';

                // Quiz 9
                SalesLine.Reset();
                // Sales Header의 PK가 두개이므로 두 개 다 연결해줘야함
                SalesLine.SetRange("Document No.", Rec."No.");
                SalesLine.SetRange("Document Type", Rec."Document Type");
                if SalesLine.FindSet() then begin
                    repeat
                        SalesLine."DXK Customer Contact" := "DXK Customer Contact";
                        SalesLine."DXK Customer Contact Name" := "DXK Customer Contact Name";
                        SalesLine.modify();
                    until SalesLine.Next() = 0;
                end;

            end;
        }
        field(56001; "DXK Customer Contact Name"; Text[30])
        {
            Caption = 'Customer Contact Name';
        }

    }
}