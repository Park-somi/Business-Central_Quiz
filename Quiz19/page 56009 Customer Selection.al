page 56009 "Customer Selection"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = Customer;
    SourceTableTemporary = true;
    Caption = 'Customer Selection';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field("Name"; Rec."Name") { ApplicationArea = All; }
            }
        }
    }
}