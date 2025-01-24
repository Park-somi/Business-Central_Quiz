pageextension 56001 SalesOrder extends "Sales Order"
{
    layout
    {
        // Quiz 8
        addafter(Status)
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
    actions
    {
        // Quiz 10(피드백)
        modify(Release)
        {
            trigger OnBeforeAction()
            var
                SalesHeader: Record "Sales Header";
                SalesLine: Record "Sales Line";
            begin
                SalesHeader.Get(Rec."Document Type", Rec."No.");
                if SalesHeader."DXK Customer Contact" = '' then begin
                    Error('General 그룹의 Customer Contact 필드가 비어있습니다.');
                end;

                SalesLine.Reset();
                SalesLine.SetRange("Document Type", Rec."Document Type");
                SalesLine.SetRange("Document No.", Rec."No.");
                SalesLine.SetFilter("DXK Customer Contact", '=%1', '');
                if SalesLine.FindFirst() then
                    Error('Lines 그룹의 Customer Contact 필드가 비어있습니다.');
            end;
        }
    }
}