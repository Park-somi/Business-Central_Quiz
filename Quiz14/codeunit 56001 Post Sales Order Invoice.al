codeunit 56001 "PostSalesOrderInvoice"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterInsertInvoiceHeader', '', true, true)]
    local procedure OnAfterInsertInvoiceHeader(var SalesHeader: Record "Sales Header"; var SalesInvHeader: Record "Sales Invoice Header")
    var
    begin
        SalesInvHeader."DXK Customer Contact" := SalesHeader."DXK Customer Contact";
        SalesInvHeader."DXK Customer Contact Name" := SalesHeader."DXK Customer Contact Name";
        SalesInvHeader.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvLineInsert', '', true, true)]
    local procedure OnAfterSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; ItemLedgShptEntryNo: Integer; WhseShip: Boolean; WhseReceive: Boolean; CommitIsSuppressed: Boolean; var SalesHeader: Record "Sales Header"; var TempItemChargeAssgntSales: Record "Item Charge Assignment (Sales)" temporary; var TempWhseShptHeader: Record "Warehouse Shipment Header" temporary; var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary; PreviewMode: Boolean)
    var
    begin
        SalesInvLine."DXK Customer Contact" := SalesLine."DXK Customer Contact";
        SalesInvLine."DXK Customer Contact Name" := SalesLine."DXK Customer Contact Name";
        SalesInvLine.Modify();
    end;
}