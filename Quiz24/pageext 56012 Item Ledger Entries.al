pageextension 56012 ItemLedgerEntries extends "Item Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field("Adjust Reason"; Rec."Adjust Reason")
            {
                ApplicationArea = All;
            }
        }
    }
}