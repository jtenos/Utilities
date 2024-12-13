// <PackageReference Include="QRCoder" Version="1.6.0" />

using QRCoder;
using System.Drawing;

const string iconFile = @"my-icon.png";
const string output = @"output.png";

QRCodeGenerator qrGenerator = new QRCodeGenerator();

QRCodeData qrCodeData = qrGenerator.CreateQrCode("https://example...", QRCodeGenerator.ECCLevel.Q);

var qrCode = new QRCode(qrCodeData);
// Adjust these until you have it the way you like it:
qrCode.GetGraphic(20, Color.FromArgb(0, 138, 196), Color.White, drawQuietZones: false, icon: (Bitmap)Image.FromFile(iconFile), iconSizePercent: 20, iconBorderWidth: 25).Save(output);
