page 56003 "Temp Posted Inv Custom"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Temp Posted Inv Custom";
    SourceTableTemporary = true;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            // 필터링 필드
            group(Filters)
            {
                group(PostingDate)
                {
                    Caption = 'Posting Date';
                    field("Posting Date From"; PostingDateFrom)
                    {
                        Caption = 'Posting Date From';
                        ApplicationArea = All;
                    }
                    field("Posting Date To"; PostingDateTo)
                    {
                        Caption = 'Posting Date To';
                        ApplicationArea = All;
                    }
                }
                group(Customer)
                {
                    Caption = 'Customer';
                    field("Customer No. From"; CustomerNoFrom)
                    {
                        Caption = 'Customer No. From';
                        ApplicationArea = All;
                        TableRelation = Customer;
                    }
                    field("Customer No. To"; CustomerNoTo)
                    {
                        Caption = 'Customer No. To';
                        ApplicationArea = All;
                        TableRelation = Customer;
                    }
                }
            }

            // 조회 필드
            repeater(Group)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    Caption = 'Customer Name';
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    Caption = 'Item No.';
                    ApplicationArea = All;
                }
                field("Item Name"; Rec."Item Name")
                {
                    Caption = 'Item Name';
                    ApplicationArea = All;
                }
                field("Customer Contact"; Rec."Customer Contact")
                {
                    Caption = 'Customer Contact';
                    ApplicationArea = All;
                }
                field("Customer Contact Name"; Rec."Customer Contact Name")
                {
                    Caption = 'Customer Contact Name';
                    ApplicationArea = All;
                }
                field("Location"; Rec."Location")
                {
                    Caption = 'Location';
                    ApplicationArea = All;
                }
                field("Quantity"; Rec.Quantity)
                {
                    Caption = 'Quantity';
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Caption = 'Unit Price';
                    ApplicationArea = All;
                }
                field("Amount"; Rec.Amount)
                {
                    Caption = 'Amount';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        // 숨겨져 있는 버튼 보여주기
        area(Promoted)
        {
            actionref(Show; "Filter and Show") { }
        }
        area(Processing)
        {
            // 필터링 버튼 만들기
            action("Filter and Show")
            {
                Caption = 'Filter and Show';
                ApplicationArea = All;
                Image = Find;

                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    SalesInvoiceLine: Record "Sales Invoice Line";
                    number: Integer;
                begin
                    Clear(Rec);
                    Rec.Reset();
                    Rec.DeleteAll();

                    number := 1;
                    SalesInvoiceHeader.Reset();

                    if CustomerNoFrom <> '' then begin
                        if CustomerNoTo <> '' then
                            SalesInvoiceHeader.SetRange("Sell-to Customer No.", CustomerNoFrom, CustomerNoTo)
                        else
                            SalesInvoiceHeader.SetFilter("Sell-to Customer No.", '>=%1', CustomerNoFrom);
                    end else begin
                        if CustomerNoTo <> '' then
                            SalesInvoiceHeader.SetFilter("Sell-to Customer No.", '<=%1', CustomerNoTo);
                    end;

                    if PostingDateFrom <> 0D then begin
                        if PostingDateTo <> 0D then
                            SalesInvoiceHeader.SetRange("Posting Date", PostingDateFrom, PostingDateTo)
                        else
                            SalesInvoiceHeader.SetFilter("Posting Date", '>=%1', PostingDateFrom);
                    end else begin
                        if PostingDateTo <> 0D then
                            SalesInvoiceHeader.SetFilter("Posting Date", '<=%1', PostingDateTo);
                    end;


                    if SalesInvoiceHeader.FindSet() then
                        repeat
                            SalesInvoiceLine.Reset();
                            SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
                            if SalesInvoiceLine.FindSet() then begin
                                repeat
                                    Rec.Init();
                                    Rec."No." := number;
                                    Rec."Customer No." := SalesInvoiceHeader."Sell-to Customer No.";
                                    Rec."Customer Name" := SalesInvoiceHeader."Sell-to Customer Name";
                                    Rec."Currency Code" := SalesInvoiceHeader."Currency Code";
                                    Rec."Item No." := SalesInvoiceLine."No.";
                                    Rec."Item Name" := SalesInvoiceLine.Description;
                                    Rec."Customer Contact" := SalesInvoiceLine."DXK Customer Contact";
                                    Rec."Customer Contact Name" := SalesInvoiceLine."DXK Customer Contact Name";
                                    Rec."Location" := SalesInvoiceLine."Location Code";
                                    Rec.Quantity := SalesInvoiceLine.Quantity;
                                    Rec."Unit Price" := SalesInvoiceLine."Unit Price";
                                    Rec.Amount := SalesInvoiceLine.Amount;

                                    Rec.Insert();
                                    number := number + 1;
                                until SalesInvoiceLine.Next() = 0;
                            end;
                        until SalesInvoiceHeader.Next() = 0;
                    Rec.FindFirst();
                end;
            }
        }
    }

    // 조회 테이블에 데이터 삽입
    trigger OnOpenPage()
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        number: Integer;
    begin
        number := 1;
        SalesInvoiceHeader.Reset();
        if SalesInvoiceHeader.FindSet() then
            repeat
                SalesInvoiceLine.Reset();
                SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
                if SalesInvoiceLine.FindSet() then begin
                    repeat
                        Rec.Init();
                        Rec."No." := number;
                        Rec."Customer No." := SalesInvoiceHeader."Sell-to Customer No.";
                        Rec."Customer Name" := SalesInvoiceHeader."Sell-to Customer Name";
                        Rec."Currency Code" := SalesInvoiceHeader."Currency Code";
                        Rec."Item No." := SalesInvoiceLine."No.";
                        Rec."Item Name" := SalesInvoiceLine.Description;
                        Rec."Customer Contact" := SalesInvoiceLine."DXK Customer Contact";
                        Rec."Customer Contact Name" := SalesInvoiceLine."DXK Customer Contact Name";
                        Rec."Location" := SalesInvoiceLine."Location Code";
                        Rec.Quantity := SalesInvoiceLine.Quantity;
                        Rec."Unit Price" := SalesInvoiceLine."Unit Price";
                        Rec.Amount := SalesInvoiceLine.Amount;

                        Rec.Insert();
                        number := number + 1;
                    until SalesInvoiceLine.Next() = 0;
                end;
            until SalesInvoiceHeader.Next() = 0;
        Rec.FindFirst();
    end;

    var
        CustomerNoFrom: Code[10];
        CustomerNoTo: Code[10];
        PostingDateFrom: Date;
        PostingDateTo: Date;
}