codeunit 56004 Release_Sales_Document
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnBeforeReleaseSalesDoc, '', false, false)]
    local procedure OnBeforeReleaseSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean; var SkipCheckReleaseRestrictions: Boolean; SkipWhseRequestOperations: Boolean)
    var
        SalesLine: Record "Sales Line";
        IsEmptyHeader, IsEmptyLine : Boolean;
        ErrorLbl: Label 'You must fill in the QA Customer Contact field in the %1';
        SalesOrder: Page "Sales Order";
        SalesLinePage: Page "Sales Order Subform";
    begin
        IsEmptyHeader := false;
        IsEmptyLine := false;

        // Sales Header의 DXK Customer Contact 필드가 비어있는지 확인
        if SalesHeader."DXK Customer Contact" = '' then
            IsEmptyHeader := true;

        // Sales Line의 DXK Customer Contact 필드가 비어있는지 확인
        SalesLine.Reset();
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange("DXK Customer Contact", '');
        if SalesLine.FindFirst() then
            IsEmptyLine := true;

        // Sales Header의 DXK Customer Contact 필드가 비어있는 경우 Error 발생
        if IsEmptyHeader then
            Error(ErrorLbl, SalesOrder.Caption());

        // Sales Line의 DXK Customer Contact 필드가 비어있는 경우 Error 발생
        if IsEmptyLine then
            Error(ErrorLbl, SalesLinePage.Caption());
    end;
}