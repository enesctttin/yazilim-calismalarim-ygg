let sonuc;
let a = 10,
  b = 20,
  c = 30;

sonuc = a + b;

console.log(a + b);

// c deki  oporetor işlemlerin aynısı   % mod alma   a=a+1   a yı bir arttırır
//  sonuc=a++  // sonuc=a+1      arttırma işlemi daha sonra olur  a artar sonuc bekler
// sonuc=++a   ise  hem sonucu hem a yı arttırır
// a--   / --a

console.log(7 + 1); // console.log içindede işlem yapılabilir

// sonuc+= a   ile   sonuc=sonuc+a   aynı şeydir
// sonuc*=a   -> sonuc=sonuc*a   hepsi için geçerli

// karşılaştırma operatörleri   boolean veri tipi döner

sonuc = a == b; // true or false

console.log(sonuc);

sonuc = a <= b;
console.log(sonuc);

//  eşit değil mi operatörü !=

// IF else
if (3 > 5) {
  // çalışmaz false değer
  console.log("merhaba");
}
if (6 > 5) {
  // çalışır
  console.log("Sa");
}

if (false) {
  // çalışmaz
  console.log("AS");
}
//  !true   bu   değer false a eşittir   ! değil işareti

let usurname = "sadik";

let kosul = usurname == "sadik"; // kosul true

if (kosul) {
  console.log("giriş yapıldı");
}
// if(!kosul){  console.log("giriş yapılamadı error")  ;   }    else alternatif
else {
  console.log("giriş yapılamadı error");
}
// if içinde if açılabilir  iki farklı koşul kullanılır  9 tek sayımı evet 9 asal sayı mı hayır gibi

let x;

if (x > 50 && x < 100) {
  console.log(" girdiğiniz sayı 50 ile 100 arasındadır");
} else {
  console.log("girdiğiniz sayı 50 ile 100 arasında değildir");
}

if (x % 2 == 0 && x > 0) {
  console.log("girdiğiniz sayı pozitif bir çift sayıdır");
} else if (x % 2 != 0 && x > 0) {
  console.log("girdiğiniz sayı pozitif bir tek sayıdır");
} else {
  console.log("girdiğiniz sayı negatif bir sayıdır");
}
//  burdan sonrası a4 e geç
//  for döngüsü

for (let i = 1; i <= 10; i++) {
  console.log("merhaba", i);
}

let xyz = null; // null boş değer demek  tanımsız değil  bilerek boş bırakıldı
let yz; //  tanımsız değişken

var dizi = [15, 16, 17, 18, 19, 20];

if (dizi.includes(17)) {
  console.log("kosul saglandı");
} else {
  console.log("calısmadı");
}
// object nesne veri tipi
let usser = {
  name: "koray",
  age: "25",
  color: "red",
};
console.log(usser.color);

//  name fonk un adı params parametre verilebilir verilmeyedebilir fonk adıyla çağırılır
function name(params) {}

function yaz() {
  alert("text");
}
yaz();

//  alert de web sitesine uyarı mesajı gelir

function write() {
  console.log("urun");
  console.log("us");
  console.log(5 + 18);
}
write(); // fonksiyon çağırma

let na = "enes";
let ss = 20;

function topla(a) {
  console.log("merhaba " + na);
  a = a + 1;
  console.log(a);
}
topla(ss);

console.log(ss);

// functionlar params kısmındaki gelen değişkenler kopya orjinal değişkenin adresi değil

var k = 14;
function hep(x) {
  return x + 10;
}

var p = hep(k);

console.log(c);

function tambolen(sayi) {
  let bolenler = [];
  for (let i = 1; i <= sayi; i++) {
    if (sayi % i === 0) {
      bolenler.push(i);
    }
  }
  return bolenler;
}
var bolenlerListesi = tambolen(28);
console.log(bolenlerListesi);

let simdi = new Date();
sonuc = simdi;
console.log(sonuc);
//   sonuc.getDate()  gün alır get kullanarak diğer ay yıl dakika da alınır

// scopes

let globalSayi = 10; // global değişken

function fonksiyon1() {
  let localSayi = 20; // local değişken
  console.log(localSayi);
  console.log(globalSayi);
}

// fonksiyon çalışırken hep ilk local değişkeni arar sonra globali
// ama global değişken olmaz sadece local olursa hata verir

const PI = 3.14; // sabit değişken  değeri değiştirilemez
// PI=3.15;  hata verir
console.log(PI);

// // //

let ornek = () => {
  console.log("arrow function");
};
ornek();
ornek = (x, y) => {
  return x + y;
};
console.log(ornek(5, 10));

//  arrow function  bu şekilde de yazılabilir

let diziii = ["elma", "armut", "muz", "çilek"];



diziii.forEach((eleman, index) => {
  console.log(index + " . " + eleman);
});
//  for each dizi elemanlarını tek tek yazdırır  index numarası ile birlikte

// map: her öğe için yeni bir dizi döner (dönüştürme için).
// forEach: geri dönüş yok; yan etki (side-effect) için kullanılır.
// Arrow function (=>) ile normal function arasındaki en önemli fark: this bağlanması, arguments ve constructor davranışlarıdır.

let sayilar = [1, 2, 3, 4, 5];

// DOĞRU KULLANIM 1 (Ok fonksiyonu ile)
let yeniisayilar = sayilar.map((item) => {
  return item * 2;
});

console.log(yeniisayilar);
//  map ile her bir dizi elemanını 2 ile çarparak yeni dizi oluşturduk



let needizi = [1, 2, 3, 4, 5, 17, 120];

const bul = needizi.filter((sayi) => sayi > 10);

console.log(bul);
// filter ile 10 dan büyük sayıları bulduk yeni dizi oluşturarak


diziii = ["elma", "armut", "muz", "çilek"];
const kelime = diziii.filter((eleman) => eleman.length > 4);

console.log(kelime);
// 4 karakterden uzun olan meyveleri filtreledik

// find ise ilk bulduğu değeri döner 
const bulun = needizi.find((sayi) => sayi > 10);

console.log(bulun); 

// object  ve array destructuring
let person = {
  firstName: "John",
  lastName: "Doe",
  age: 30,
};

let {firstName, age} = person;

console.log(firstName);

//  distructuring ile object içindeki verilere kolay erişim sağladık
let numbers = [1, 2, 3, 4, 5];  
let [bir, iki, , dort] = numbers;

console.log(dort); 
//  array destructuring ile  dizinin 4. elemanına eriştik   3. elemanı atladık
// rest operatörü  ...  kalan tüm elemanları alır
let [ilk, ...geriKalan] = numbers;
console.log(geriKalan);
//  geri kalan tüm elemanları dizi olarak aldı  

//  spread operatörü  ...  bir diziyi başka bir diziye yaymak için kullanılır
let dizi1 = [1, 2, 3];
let dizi2 = [4, 5, 6];
let birlesikDizi = [...dizi1, ...dizi2];
console.log(birlesikDizi);
//  iki diziyi birleştirdik  spread operatörü ile
// spread operatörü ... dır 

// Dom Donimasyonu ile element seçme ve değiştirme
//  document ile html elementlerine erişilir

let sayma=0;

const sayiElement =document.getElementById("count");

console.log(sayiElement);

function guncelle(){
  sayiElement.innerText=sayma;
}
function arttir(){
  sayma++;
  guncelle();
}

function azalt(){
  // kosul ekledik sayma sıfırın altına inmesin
  // koşul true ise çalışır 
  
  if( sayma>0){
    sayma--;
  }
  guncelle();
} 

// butonlara tıklanınca sayma değişkeni artar veya azalır ve guncelle fonksiyonu ile html deki sayı güncellenir
// innerText ile elementin içindeki metin değiştirilir
// getElementById ile id ye göre element seçilir
//  diğer element seçme yöntemleri de vardır  class name tag name query selector gibi

// query selector ile element seçme
// burada id si count olan elementi seçtik
 
let queryElement = document.querySelector("#count");
console.log(queryElement);
//  query selector ile id seçimi # ile yapılır  class için . ile yapılır









