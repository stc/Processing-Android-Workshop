import apwidgets.*;
import android.text.InputType;
import android.view.inputmethod.EditorInfo;

PWidgetContainer container;
PEditText textField, numbersField, textField2, phoneNumberField;

String info = "";

void setup() {
  container = new PWidgetContainer( this );

  textField = new PEditText( 0, 50, width/2, 50 );
  container.addWidget( textField );
  textField.setInputType(InputType.TYPE_CLASS_TEXT); //Set the input type to text
  textField.setImeOptions(EditorInfo.IME_ACTION_NEXT); //Enables a next button, shifts to next field

  numbersField = new PEditText(width/2, 50, width/2, 50 );
  textField.setNextEditText(numbersField); //Manually set which field to shift to next. Must be set AFTER the target is initialized
  container.addWidget( numbersField );
  numbersField.setInputType(InputType.TYPE_CLASS_NUMBER); //Set the input type to number
  numbersField.setImeOptions(EditorInfo.IME_ACTION_NEXT); //Enables a next button, shifts to next field
  
  textField2 = new PEditText( 0, 150, width/2, 50 );
  numbersField.setNextEditText(textField2); //Manually set which field to shift to next. Must be set AFTER the target is initialized
  container.addWidget(textField2);
  textField2.setInputType(InputType.TYPE_CLASS_TEXT); //Set the input type to text
  textField2.setImeOptions(EditorInfo.IME_ACTION_NEXT); //Enables a next button, shifts to next field
  
  phoneNumberField = new PEditText( width/2, 150, width/2, 50 );
  textField2.setNextEditText(phoneNumberField); //Manually set which field to shift to next. Must be set AFTER the target is initialized
  container.addWidget( phoneNumberField);
  phoneNumberField.setInputType(InputType.TYPE_CLASS_PHONE); //Set the input type to phone number 
  phoneNumberField.setImeOptions(EditorInfo.IME_ACTION_DONE); //Enables a Done button
  phoneNumberField.setCloseImeOnDone(true); //close the IME when done is pressed

}

void draw() {
  text(info, 0, 250); 
}

//If setImeOptions(EditorInfo.IME_ACTION_DONE) has been called 
//on a PEditText. onClickWidget will be called when done editing.
void onClickWidget(PWidget widget) {  
  if(widget == phoneNumberField){ //
    info = textField.getText()+"\n"+
      numbersField.getText()+"\n"+
      textField2.getText()+"\n"+
      phoneNumberField.getText();
  }
}

