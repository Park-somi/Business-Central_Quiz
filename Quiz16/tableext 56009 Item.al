tableextension 56009 Item extends "Item"
{
    fields
    {
        field(56000; "Item Type"; Option)
        {
            Caption = 'Item Type';
            OptionMembers = ,Vehicle,Bicycle;
        }
        field(56001; "Brand Code"; Code[10])
        {
            Caption = 'Brand Code';

            TableRelation =
            if ("Item Type" = const(Vehicle)) "Vehicle Brand".Code
            else if ("Item Type" = const(Bicycle)) "Bicycle Brand".Code;
        }
    }
}