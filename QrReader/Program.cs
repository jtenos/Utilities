//  <PackageReference Include="ZXing.Net" Version="0.9.0" />
// Seems like the newer versions aren't as simple - this old version seems to work just fine

var bmp = (Bitmap)Image.FromFile("G:\\My Drive\\image.png");
var bcreader = new BarcodeReader { AutoRotate = false };
var result = bcreader.Decode(bmp);
Console.WriteLine(result.Text);
