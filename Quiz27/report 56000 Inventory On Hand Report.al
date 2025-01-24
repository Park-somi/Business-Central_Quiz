report 56000 "Inventory On Hand Report"
{
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Inventory On Hand Report';
    ApplicationArea = All;
    DefaultLayout = Word;
    WordLayout = 'InventoryOnHandReport.docx';

    dataset
    {
        dataitem(InventoryOnHand; "Inventory On Hand List")
        {
            UseTemporary = true;
            DataItemTableView = sorting("Item No.", Location, "Current Qty");

            column(ItemNo; "Item No.") { }
            column(ItemDesc; "Item Desc") { }
            column(Location; Location) { }
            column(CurrentQty; "Current Qty") { }

            // trigger OnAfterGetRecord()
            // begin
            //     if FilterItemNo <> '' then
            //         if "Item No." <> FilterItemNo then
            //             CurrReport.Skip();

            //     if FilterLocation <> '' then
            //         if Location <> FilterLocation then
            //             CurrReport.Skip();

            //     if HasAvailableQty then
            //         if "Current Qty" <= 0 then
            //             CurrReport.Skip();
            // end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(FilterItemNo; FilterItemNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Item No.';
                        TableRelation = Item."No.";
                    }
                    field(Location; FilterLocation)
                    {
                        ApplicationArea = All;
                        Caption = 'Location';
                        TableRelation = Location.Code;
                    }
                    field(HasAvailableQty; HasAvailableQty)
                    {
                        ApplicationArea = All;
                        Caption = 'Has Available Qty';
                    }
                }
            }
        }
    }

    // (1) 임시 테이블
    // : 테이블에 데이터가 없으므로 OnPreReport에서 데이터를 채워넣어야 DataItem 로직에서 데이터 사용 가능

    // (2) 실제 테이블
    // : 테이블에 이미 데이터가 존재하므로 DataItem에서 직접 테이블 데이터 접근

    // 리포트 실행 시 가장 먼저 실행
    trigger OnPreReport()
    var
        Item: Record Item;
        Location: Record Location;
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalQty: Decimal;
        number: Integer;
    begin
        number := 1;

        Item.Reset();
        if FilterItemNo <> '' then
            Item.SetRange("No.", FilterItemNo);
        if Item.FindSet() then
            repeat
                Location.Reset();
                if FilterLocation <> '' then
                    Location.SetRange("Code", FilterLocation);
                if Location.FindSet() then
                    repeat
                        ItemLedgerEntry.Reset();
                        ItemLedgerEntry.SetRange("Item No.", Item."No.");
                        ItemLedgerEntry.SetRange("Location Code", Location.Code);

                        TotalQty := 0;
                        if ItemLedgerEntry.FindSet() then
                            repeat
                                TotalQty += ItemLedgerEntry.Quantity;
                            until ItemLedgerEntry.Next() = 0;

                        if not HasAvailableQty then begin
                            InventoryOnHand.Init();
                            InventoryOnHand."No." := number;
                            InventoryOnHand."Item No." := Item."No.";
                            InventoryOnHand."Item Desc" := Item.Description;
                            InventoryOnHand.Location := Location.Code;
                            InventoryOnHand."Current Qty" := TotalQty;
                            InventoryOnHand.Insert();
                            number += 1;
                        end else
                            if TotalQty > 0 then begin
                                InventoryOnHand.Init();
                                InventoryOnHand."No." := number;
                                InventoryOnHand."Item No." := Item."No.";
                                InventoryOnHand."Item Desc" := Item.Description;
                                InventoryOnHand.Location := Location.Code;
                                InventoryOnHand."Current Qty" := TotalQty;
                                InventoryOnHand.Insert();
                                number += 1;
                            end;
                    until Location.Next() = 0;
            until Item.Next = 0;
    end;


    var
        HasAvailableQty: Boolean;
        FilterItemNo: Code[20];
        FilterLocation: Code[10];
}