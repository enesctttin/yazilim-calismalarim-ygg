// değişkenler

// console.log fonksiyonu ile console üzerine çıktı verebiliriz

// script dosyanın çalışıp çalışmadığını görmek  için html dosyasını çalışıtır. console kısmından kontrol et çıktıları

console.log(5000 * 1.2);
console.log(6000 * 1.5);

//  var  değişken tanımlamaya yarar int char gibi

var a = 3000;
var kdv = 3.4;
console.log(a);
console.log(a / 2);
console.log(a * kdv);

// bu bilgiler ram bellekde saklanır
// bu değişkenler adreslerde saklanır

// değişken tanımlarken let veya var kullanılır farkı daha sonra anlatılacak
// derleyici kodu yukarıdan aşağı doğru okur

a; // 3000
a = 8000; // a nın yeni değeri 8000

// değişken tanımlama kuralları türkçe karakter olmamalı  İ Ü Ç ç  gibi
// arada bosluk olmamalı var en es olmaz  en_es
// sayı ile başlanmaz
// komut isimleri değişken olarak kullanılamaz   var for=10; gibi

// ders 3  değişken türleri

//  karakter dizisi string tanımlarken ' '    " "   kullanılabilir  hiç farketmez

var urunAdi = "Iphone 16 "; // string

var urunFiyat = "7000"; // string

var urunfiyat2 = 70000; // number

// console.log(typeof değişken adi )   değişkenin tipini gösterir  console da yazar

console.log(typeof urunFiyat);

console.log(typeof urunFiyat1);

console.log(typeof urunfiyat2);

// stringler ile matematiksel işlemler yapılamaz  fakat console.log  'printf 'imizin içine de iki değişken tipinide yazdırabiliriz

var ad = "enes";
var soyad = "cetin";

console.log(ad + soyad); //  çıktı enescetin   arada boşluk yok

console.log(ad + " " + soyad); // araya bosluk ekler

console.log(ad + " burasi " + soyad); // tırnak konursa ek yazim yapılabilir  enes burasi cetin

ad = "ali";
// buraya kadar olan bütün ad değişkeni enesi taşır kullanıldığı yerlede enes değişkenini çağırır
// altta ise   ad değişkeni ali olur sonrasında ise ali çağırır
console.log(ad);

// boolen tipi

var sinavnotu = 60;

var bayrakbasarilimi = sinavnotu >= 50; // boolean => true, false

console.log(bayrakbasarilimi); // 1 ya da 0 döndürücek false or true

var yas; //  bi değer atamadık

console.log(yas); // undefined
console.log(typeof yas); // undefined  yazar  sebebi yukarıda tanımlama yapmamış olmamaız

// uygulama değişkenler

var ogr1_mat1 = 70;

var ogr1_mat2 = 60;

var ogr1_mat3 = 10;

var ort1 = (ogr1_mat1 + ogr1_mat2 + ogr1_mat3) / 3; //46.3
console.log(ort1);

console.log(parseInt(ort1)); // parseInt komutu değişkenin tipini int yapar virgülden sonrası gözükmez  //46

//parseFloat komutu ise değişkeni float tipine çevirir

//  stringler

var ad11 = "Sadık";

console.log(ad11[0]); // string dizisinin 0. elemanına gider    index 0 dan başlar

var soyadd = "Turan";

var yas = 40;

var sehir = "kocaeli";

var mesaj =
  " Benim adim " +
  ad11 +
  "ve soyadım " +
  soyadd +
  ". " +
  sehir +
  "' de yaşıyorum " +
  (65 - yas) +
  " yılım kaldı";
// ' '\ '  çıktı '  ekrana yazar

console.log(mesaj);

// Template strings
// değişken tekrar altta oluşturulabilir  var mesaj    var yerine let kullanılırsa ise alltta tanımlanamaz
mesaj = `  Benim adim ${ad11}  ve soyadım ${soyadd}. ${sehir} ' de yaşıyorum  ${
  65 - yas
} yılım kaldı  `;
// back tick `` virgül+ alt gr
console.log(mesaj);

// string methodları

var kursAdi = "Komple web geliştirme Eğitimi";
var sonuc;

sonuc = kursAdi.toUpperCase; // kursAdi. koyduktan sonra kutuphane açılır buradan methodlar uygulanır
sonuc = kursAdi.length;

sonuc = kursAdi[5]; //  5. indexdeki karakteri alır   yani  e    index 0 dan başlar

sonuc = kursAdi.slice(0, 3); //  0 dan 3 . indexe kadar olan harflari alır

sonuc = kursAdi.slice(10); // 10. indexten sonrasını alır en sona kadar

sonuc = kursAdi.slice(-10); //  sağdan sayarak almaya başlar 10 karakter alır

sonuc = kursAdi.substring(0, 6); // 0 ile 6 arası karakterleri al

sonuc = kursAdi.substring(10); //  10. indexten sonrasını alır en sona kadar

sonuc = kursAdi.replace("Eğitimi", "Kursu"); // Eğitimi kelimesi yerine Kursu gelimesin yazar

sonuc = kursAdi.trim(); //  başlangıç ve sondaki  karakterleri siler   trimEnd  trimStar özel halleri

sonuc = kursAdi.indexOf("Komple"); //  Komple nin ilk karakterinin başlangıç indexini verir 0

sonuc = kursAdi.split(","); //   ilgili karakteri  görünce böl  stringi parçalamaya yarar ve yeni dizi olşturur böldüğü yerlerden
// "Komple","web" ,"geliştirme","Eğitimi"  yeni dizi
sonuc = kursAdi.split(" ")[1]; // boşluk koyduk  web gelir

//  internet üzerinden js string methodları yazınca deyaylı arama yapılabilir w3school
console.log(sonuc);

// Uygulama

//   Bunlar kendin araştırıp öğrenilecek   js string methodları web de ara

let url = "https://www.sadikturan.com";
let Kursinaadi = "Komple Web Geliştirme Kursu";

//  1-  url kaç karakterdir ?

let x;

x = url.length; // stringin kaç karakter olduğu gözükür

console.log(x);

//  2- Kursinaadi kaç kelimeden oluşur ?

x = Kursinaadi.split(""); // boşluklardan bölerek yeni dizi oluşturur

console.log(x);

x = Kursinaadi.split("").length; //  yeni oluşan dizinin elemanlarını verir

console.log(x);

//  3- url https ile mi başlıyor ?

x = url.startsWith("https"); //  string bunulamı başlıyor diye kontrol eder startWidh in üstüne gelince döndürdüğü veri tipini söyler startWidh boolen tipi döner

console.log(x); // boolen tipi true / false sonucu döndürür

//  4- Kursinaadi içerisinde Eğitimi kelimesi var mı ?

x = Kursinaadi.indexOf("Eğitimi"); // kelime varsa indexdeki başlangıç index değerini getirir eğer string yoksa -1 döner

console.log(x);

//  5- url ve Kursinaadi değişkenlerini kullanarak aşağıdaki string bilgiyi oluşturunuz.
//  https://www.sadikturan.com/komple-web-gelistirme-kursu

Kursinaadi = Kursinaadi.toLowerCase();
Kursinaadi = Kursinaadi.replaceAll(" ", "-");
Kursinaadi = Kursinaadi.replace("ş", "s"); // replace ilk karakteri varsa ikinci karaktere dönüştürür
x = `${url}/${Kursinaadi}`;

console.log(x);

// Numberss    javascript math kutuphanesi arama

let y;
y = 10;
console.log(y);
y = "10"; // string veri
console.log(y);

y = Number("y"); // stringi veri tipini number yapıyoruz
console.log(y);

y = parseInt("10"); // 10.5 float veri  veri tipini a varsa çeviremez  çevire bildiği kadarını çevirir 15a ->15  a15 -> not a number  (girdi-> çıktı)
console.log(y);

y = isNaN("a10"); // is not a number ?
console.log(y);

y = Number.isInteger(10); // boolen  tip sorgular true /false
console.log(y);

let sss = 10.12345;
console.log(sss.toPrecision(5)); // toPrecision(5) sadece 5 basamak sayı yazdırır ekrana ve yuvarlar

console.log(sss.toFixed(2)); // . dan sonra iki basamak gösterir

y = Math.round(2.4); // yuvarlama  yapar birinci değeri alır ikini değeri yuvarlar
console.log(y);
y = Math.round(2.6);
console.log(y);

y = Math.sqrt(25); // sqrt kök alır
console.log(y);

y = Math.pow(2, 4);
console.log(y);
y = Math.min(-5, 4, 5, 11, 8); // max metodu da var
console.log(y);

y = Math.random(); // random sayı üretir *10 yapılabilir veya +4 eklenebilir
console.log(y);
y = Math.random() + 4; // random sayı 0 ile 1 arasında üretilir
console.log(y);
y = Math.floor(Math.random() * 10 + 1); // floor ceil  yuvarlama yapar fonksiyon içinde fonksiyon
console.log(y); // random()*100 +1   1 ile 100 arasında random sayı üretir
console.log(typeof y); // veri tipini yazar

//  Diziler
// let ile bir kere değişken oluşturulur bir daha aynı değişkeni let ile oluşturursak hata alırız
//  var ise aynı değişkeni birden çok oluşturmamıza yarar var ile değişkeni eski değişkeni kayıp ederiz
let urun1 = "Iphone 15";
let urun2 = "Iphone 14";
let urun3 = "Iphone 13";
// dizi tanımlama   köşeli parantez kullanılır []
let urunler = ["Iphone 15", "Iphone 13", "Iphone 12"]; // string dizi

let fiyatlar = [5000, 4000, 2000];

let z = `${urunler[0]}`;

console.log(z);

z = `${urunler[0]} - ${fiyatlar[0]}`;

console.log(z);

// bir dizi içerisinde

let urun4 = ["Iphone 8", 1000];

let zz = `${urun4[0]}  ${urun4[1]}  `;

console.log(urun4);

console.log(zz);

// dizi içinde bir dizi daha oluşruma matris
let urun5 = ["Iphone X", 1500, ["mavi", "sarı", "kırmızı"]];

let zzz = `${urun5[0]}  ${urun5[1]}  ${urun5[2]}  `;

console.log(zzz); // çıktı  Iphone X   1500   mavi,sarı,kırmızı

//  urun5[2][2]  ile vektör seçtik vektörün içindede konum seçtik
zzz = `${urun5[0]}  ${urun5[1]}  ${urun5[2][2]}  `;

console.log(zzz); // çıktı  Iphone X   1500 kırmızı

//  dizi içindeki elemanlara erişme
urun5[0] = "Iphone X pro";

zzz = `${urun5[0]}  ${urun5[1]}  ${urun5[2][2]}  `;

console.log(zzz);

// dizi metodları

let ogrenciler = ["Cınar", "Arda", "Kamil"];

let t;

t = ogrenciler.length; // dizinin eleman sayısını verir
console.log(t);

t = ogrenciler.toString(); //  diziden string bilgiye dönüşür   tostring bir methoddur ve methodları ()  çağırmamız şart
console.log(t);

t = ogrenciler.join("-"); //  virgül yerine özelleştirdiğimiz bir karakteri yazdırırız yukarıdakinden farklı
console.log(t);

// eleman silem

t = ogrenciler.pop(); // son elemanı siler
console.log(t); //  sildiği elemanı değişken tutar  diziden eleman koparır
console.log(ogrenciler); // yeni dizi "Cınar","Arda" şeklinde olur

t = ogrenciler.shift(); // ilk elemanı siler diziden kendisi ilk elemanı tutar
console.log(t);

//eleman ekleme

t = ogrenciler.push("Sena"); // listenin sona eklme yapar

console.log(t); // bu dizinin uzunluğunu yazar

console.log(ogrenciler);

t = ogrenciler.unshift("alp"); // listenin başına ekleme yapar

console.log(t);
console.log(ogrenciler);

// liste üzerinde eleman arama indexof dizideki indexi döner veya dizide aranan eleman yoksa -1 döner

t = ogrenciler.indexOf("Arda"); // arda nın index numarası 1 miş yani ikinci eleman
console.log(t);

t = ogrenciler.indexOf("Arda11");
console.log(t);

// bir dizide aynı elemandan iki tane varsa ilk gördüğü elemanı getirir  soldan tarama yap gördüğün zaman index numarasını al ve dur sonucu getir şeklinde çalışır
// last index of ise sondan arama yapar

t = ogrenciler.includes("Arda"); // listede bu eleman var mı yok mu boolen tipi döner

// hem silme ,ekleme methodu  splice()
console.log(ogrenciler);

t = ogrenciler.splice(0, 1); // 0.ncı konumdan itibaren 1 eleman sil
console.log(t); // silinen elemanı döndürür/ tutar
console.log(ogrenciler);

t = ogrenciler.splice(0, 0, "Zeynep", "Ufuk"); // 0 , 0 , eklemek istediğimiz elemanlar  eklenmek istenen yana yazılır silme işlemi de yapılabilir birinci indexde 0 yerine 1 yazılırsa birden ekleme yapar
console.log(t);

console.log(ogrenciler);

//   js medhot array internet aramasıyla bunları bulabiliriz
//    variable.sort();    sort();  alfabetik sırayla getirir
//    reverse ise ilk elemanı sona 2. elemanı n-1 e sırayı değiştirir.

//  ilk olarak diziden length bilgisi almak önemli sonrasında yaptırcağımız işlmeleri bunu kullanıcaz
// son elemanı çağırrken  t=array.length       t-1  son elemanı  çağırır
//  sona eleman eklerken   array[t]= s ;son eleman a gider bu

// nesneler (objects)  tanımlama yapılırken süslü parantez kullanılır typdef kullanımına benzer  
// ana değişken ana değişkenin alt değişkeni  öğrenci yaşı sınıfı     öğrenci.sınıfı gibi
// obje altında bir obje daha tanımlanabilir
// nesen tanımlamada index lere " variable ": "someting "     variable değişkeni ile erişebiliriz

let kullanici ={
    "ad":"Sadık",
    "soyad":"turan",
    "yas":40

};

let hedef;
hedef=kullanici;
console.log(hedef);
hedef=kullanici["ad"];
console.log(hedef);

hedef=kullanici["soyad"];
console.log(hedef);


let siparis_1={
    "id":101,
    "musteri_id":12,
    "tarih":"31.12.2025",
    "odeme_sekli":"kredi kartı",
    "kargo_adresi":{
        "mahalle":"yahya kaptan mah.",
        "ilce":"izmit",
        "sehir":"kocaeli",
    },
    "urunler":[
        {
            "urun_id":5,
            "urun_adi":"Iphone 15",
            "fiyat":75000
        },
         {
            "urun_id":6,
            "urun_adi":"Iphone 15 pro",
            "fiyat":85000
        }
    ]
};




let siparis_2={
    "id":102,
    "musteri_id":12,
    "tarih":"01.01.2026",
    "odeme_sekli":"kredi kartı",
    "kargo_adresi":{
        "mahalle":"yahya kaptan mah.",
        "ilce":"izmit",
        "sehir":"kocaeli",
    },
    "urunler":[
        {
            "urun_id":8,
            "urun_adi":"Iphone 13",
            "fiyat":75000
        }
    ]
};

let totalcost1=(siparis_1.urunler[0].fiyat + siparis_1.urunler[1].fiyat);
console.log(totalcost1*1.2);

console.log(siparis_2.urunler[0].fiyat);
