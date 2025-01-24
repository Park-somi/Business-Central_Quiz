pageextension 56011 ItemJournalLines extends "Item Journal"
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