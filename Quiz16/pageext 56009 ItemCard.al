pageextension 56009 ItemCard extends "Item Card"
{
    layout
    {
        addafter("Base Unit of Measure")
        {
            field("Item Type"; Rec."Item Type")
            {
                ApplicationArea = All;
            }
            field("Brand Code"; Rec."Brand Code")
            {
                ApplicationArea = All;
            }
        }
    }
}