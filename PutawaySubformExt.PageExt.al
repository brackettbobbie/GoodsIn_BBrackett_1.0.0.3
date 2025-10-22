pageextension 50148 PutawaySubformExt extends "Whse. Put-away Subform"
{
    actions
    {
        addafter("&Line")
        {
            group("Goods In")
            {
                action(Print_Label)
                {
                    Caption = 'Print Label';
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        if(Rec."Lot No." > '') //and (Rec."Qty. to Handle" > 0)
                        then begin
                            //Message('We can print a label - Lot No. ' + Rec."Lot No." + ', Qty. to Handle ' + Format(Rec."Qty. to Handle", 0, 0));
                            PutawaySubFormRec."Activity Type":=Rec."Activity Type";
                            PutawaySubFormRec."No.":=Rec."No.";
                            PutawaySubFormRec."Line No.":=Rec."Line No.";
                            PutawaySubFormRec.SetRecFilter();
                            Report.Run(50147, true, false, PutawaySubFormRec);
                        end
                        else
                        begin
                            Message('We cannot print a label - Lot No. ' + Rec."Lot No." /*+ ', Qty. to Handle ' + Format(Rec."Qty. to Handle", 0, 0)*/);
                        end;
                    end;
                }
            }
        }
    }
    var PutawaySubFormRec: Record "Warehouse Activity Line" temporary;
    JustPrintedThis: Text[1024];
    PrintThis: Text[1024];
    MyPrint: Boolean;
}
