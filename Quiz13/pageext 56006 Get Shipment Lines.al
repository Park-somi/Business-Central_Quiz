pageextension 56006 GetShipmentLines extends "Get Shipment Lines"
{
    layout
    {
        addafter("No.")
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