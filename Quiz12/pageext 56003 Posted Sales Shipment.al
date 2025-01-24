pageextension 56003 PostedSalesShipment extends "Posted Sales Shipment"
{
    layout
    {
        addafter("Order No.")
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
}