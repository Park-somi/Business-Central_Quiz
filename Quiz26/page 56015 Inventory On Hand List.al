page 56015 "Inventory On Hand List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Inventory On Hand List";
    SourceTableTemporary = true;
    Caption = 'Inventory On Hand List';
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(Filters)
            {
                field("Filter Item No."; FilterItemNo)
                {
                    Caption = 'Item No.';
                    ApplicationArea = All;
                    TableRelation = Item."No.";

                    trigger OnValidate()
                    begin
                        ApplyFilters();
                    end;
                }
                field("Has Available Qty"; HasAvailableQty)
                {
                    Caption = 'Has Available Qty';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ApplyFilters();
                    end;
                }
                field("Filter Location"; FilterLocation)
                {
                    Caption = 'Location';
                    ApplicationArea = All;
                    TableRelation = Location.Code;

                    trigger OnValidate()
                    begin
                        ApplyFilters();
                    end;
                }
            }
            repeater(Group)
            {
                Editable = false;

                field("Item No."; Rec."Item No.") { ApplicationArea = All; Editable = false; }
                field("Item Desc"; Rec."Item Desc") { ApplicationArea = All; Editable = false; }
                field("Location"; Rec.Location) { ApplicationArea = All; Editable = false; }
                field("Current Qty"; Rec."Current Qty") { ApplicationArea = All; Editable = false; }
            }
        }
    }

    trigger OnOpenPage()
    var
        Item: Record "Item";
        Location: Record "Location";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalQty: Integer;
        number: Integer;
    begin
        HasAvailableQty := false;
        number := 1;

        Item.Reset();
        if Item.FindSet() then
            repeat
                Location.Reset();
                if Location.FindSet() then
                    repeat
                        // Location별 재고 수량
                        ItemLedgerEntry.Reset();
                        ItemLedgerEntry.SetRange("Item No.", Item."No.");
                        ItemLedgerEntry.SetRange("Location Code", Location.Code);

                        // 수량 합계 계산
                        TotalQty := 0;
                        if ItemLedgerEntry.FindSet() then
                            repeat
                                TotalQty += ItemLedgerEntry.Quantity;
                            until ItemLedgerEntry.Next() = 0;

                        Rec.Init();
                        Rec."No." := number;
                        Rec."Item No." := Item."No.";
                        Rec."Item Desc" := Item.Description;
                        Rec.Location := Location.Code;
                        Rec."Current Qty" := TotalQty;
                        Rec.Insert();
                        number := number + 1;
                    until Location.Next() = 0;
            until Item.Next = 0;
    end;

    local procedure ApplyFilters()
    begin
        Rec.Reset();

        if FilterItemNo <> '' then
            Rec.SetRange("Item No.", FilterItemNo);

        if FilterLocation <> '' then
            Rec.SetRange("Location", FilterLocation);

        if HasAvailableQty then
            Rec.SetFilter("Current Qty", '>0');

        CurrPage.Update(false);
    end;

    var
        HasAvailableQty: Boolean;
        FilterItemNo: Text;
        FilterLocation: Text;
}