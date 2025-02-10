codeunit 56000 "PostSalesOrderShipment"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterInsertShipmentHeader', '', true, true)]
    local procedure OnAfterInsertShipmentHeader(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header")
    begin
        SalesShipmentHeader."DXK Customer Contact" := SalesHeader."DXK Customer Contact";
        SalesShipmentHeader."DXK Customer Contact Name" := SalesHeader."DXK Customer Contact Name";
        SalesShipmentHeader.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterInsertShipmentLine', '', true, true)]
    local procedure OnAfterInsertShipmentLine(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var SalesShptLine: record "Sales Shipment Line"; PreviewMode: Boolean; xSalesLine: Record "Sales Line")
    begin
        SalesShptLine."DXK Customer Contact" := SalesLine."DXK Customer Contact";
        SalesShptLine."DXK Customer Contact Name" := SalesLine."DXK Customer Contact Name";
        SalesShptLine.Modify();
    end;
}
