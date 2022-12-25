
Button[] ButtonStorage = new Button[] {};

class Button {
  PVector pos, size;
  int borderSize, textSize,buttonTransparency;
  String purpose, text;
  color borderColor;
  boolean usePreset;
  Button(PVector pos, PVector size, String purpose, String text, int textSize, int borderSize, color borderColor, int buttonTransparency, boolean usePreset) {
    this.pos = pos;
    this.size = size;
    this.purpose = purpose;
    this.text = text;
    this.textSize = textSize;
    this.borderSize = borderSize;
    this.borderColor = borderColor;
    this.buttonTransparency = buttonTransparency;
    this.usePreset = usePreset;
  }
  void show(){
    if(usePreset == true){
      textAlign(CENTER,CENTER);
      noStroke();
      fill(borderColor, buttonTransparency);
      rect(pos.x, pos.y, size.x, size.y);
      makeBorders(int(pos.x), int(pos.y), int(size.x), int(size.y), borderSize, borderColor);
      fill(borderColor);
      textSize(textSize);
      text(text, pos.x + size.x/2, pos.y + size.y/2 - textSize/5); 
    
    }
   
  }
}
