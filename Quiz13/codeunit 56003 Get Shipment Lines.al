codeunit 56003 "Get Shipment Lines"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Get Shipment", OnBeforeInsertInvoiceLineFromShipmentLine, '', false, false)]
    local procedure OnBeforeInsertInvoiceLineFromShipmentLine(SalesShptHeader: Record "Sales Shipment Header"; var SalesShptLine2: Record "Sales Shipment Line"; var SalesHeader: Record "Sales Header"; var PrepmtAmtToDeductRounding: Decimal; TransferLine: Boolean; var IsHandled: Boolean; var SalesShptLine: Record "Sales Shipment Line"; var SalesLine: Record "Sales Line")
    begin
        SalesLine."DXK Customer Contact" := SalesShptLine."DXK Customer Contact";
        SalesLine."DXK Customer Contact Name" := SalesShptLine."DXK Customer Contact Name";
    end;
}