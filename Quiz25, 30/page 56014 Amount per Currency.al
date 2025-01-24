page 56014 "Amount per Currency"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Amount per Currency";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        GetLCYAmount();
                    end;
                }
                field("Amount"; Rec.Amount)
                {
                    ApplicationArea = All;
                    AutoFormatType = 1;
                    AutoFormatExpression = Rec."Currency Code"; // 선택한 Currency Code에 따라서 입력할 수 있는 소수점 자릿수가 정해짐

                    trigger OnValidate()
                    begin
                        GetLCYAmount();
                    end;
                }
                field("LCY Amount"; Rec."LCY Amount")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        GetLCYAmount();
                    end;
                }
                field("Date"; Rec.Date)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        GetLCYAmount();
                    end;
                }
            }
        }
    }

    procedure GetLCYAmount()
    var
        CurrExchRate: Record "Currency Exchange Rate";
    begin
        Rec."LCY Amount" := CurrExchRate.ExchangeAmount(
            Rec.Amount,
            Rec."Currency Code",
            '', // 빈 문자열은 LCY를 의미
            Rec.Date // 비어있으면 자동으로 WorkDate()가 들어감
        );
        Rec.Modify();
    end;
}