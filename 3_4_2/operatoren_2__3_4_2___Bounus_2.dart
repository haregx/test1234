void main() {
 // Test 1
 double totalAmount = 150;
 bool isStudent = true;
 bool hasVoucher = false;
 bool isLoyalCustomer = false;


 print(getString(getDiscount(totalAmount, isStudent, hasVoucher, isLoyalCustomer), totalAmount));
  // Test 2
 totalAmount = 250;
 isStudent = false;
 hasVoucher = true;
 isLoyalCustomer = true;


 print(getString(getDiscount(totalAmount, isStudent, hasVoucher, isLoyalCustomer), totalAmount));


}


String getString(double discount, double totalAmount) {
 return "Preis: ${totalAmount.toStringAsFixed(2).replaceAll('.', ',')} € | " +
       "Rabatt: $discount % - ${discount > 15 ? 'Super Spar-Deal!' : discount > 0 ? 'Normaler Rabatt' : 'Standardpreis'} | " +
       "Zu zahlen: ${(totalAmount * (1 - discount / 100)).toStringAsFixed(2).replaceAll('.', ',')} €";
}


double getDiscount(double totalAmount, bool isStudent, bool hasVoucher, bool isLoyalCustomer) {
 double maxDiscount = 0;
 if (hasVoucher) {
   maxDiscount = 15;
 } else if (isLoyalCustomer) {
   maxDiscount = 10;
 } else if (isStudent) {
   maxDiscount = 5;
 }
 if (totalAmount > 200) {
   maxDiscount += 5;
 }
 return maxDiscount;
}
