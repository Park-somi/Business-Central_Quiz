page 56008 "Multiple Customers"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Multiple Customers";
    Caption = 'Multiple Customers';
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.") { ApplicationArea = All; }
                field("Customer No."; Rec."Customer No.") { ApplicationArea = All; }
                field("Customer Name"; Rec."Customer Name") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            actionref(Show; "Insert Multi Customers") { }
        }
        area(Processing)
        {
            action("Insert Multi Customers")
            {
                Caption = 'Insert Multi Customers';
                ApplicationArea = All;
                Image = Add;

                trigger OnAction()
                var
                    CustomerPopup: Page "Customer List";
                    Customer: Record Customer;
                begin
                    // Customer List 페이지를 Lookup 모드로 설정
                    CustomerPopup.LookupMode := true;

                    // 페이지 실행
                    if CustomerPopup.RunModal() = Action::LookupOK then begin
                        CustomerPopup.SetSelectionFilter(Customer); // 선택한 레코드 가져오기

                        if Customer.FindSet() then
                            repeat
                                Rec.Init();
                                Rec."Entry No." := 0;
                                Rec."Customer No." := Customer."No.";
                                Rec."Customer Name" := Customer.Name;
                                Rec.Insert();
                            until Customer.Next() = 0;
                    end;
                end;
            }
        }
    }
}