let sonuc;

sonuc=document.all;
// Tüm elementleri seçer ve HTMLCollection olarak döner

console.log(sonuc);

// Belirli bir indexteki elementi seçme
sonuc=document.all[5];
console.log(sonuc); 

// Toplam element sayısını öğrenme
sonuc=document.all.length;
console.log(sonuc); 


// Belirli bir indexteki elementi stillendirme
document.all[10].style.background="red";
document.all[10].style.color="white";   

// Belirli bir indexteki elementi gizleme
document.all[15].style.display="none";      

// Belirli bir indexteki elementi gösterme
document.all[15].style.display="block"; 

// Belirli bir indexteki elementi alma ve içeriğini değiştirme
sonuc=document.all[8].innerText;
console.log(sonuc); 

document.all[8].innerText="Yeni Başlık";
console.log(document.all[8]);

// Belirli bir indexteki elementi alma ve HTML içeriğini değiştirme
sonuc=document.all[12].innerHTML;
console.log(sonuc);     
document.all[12].innerHTML="<b>Yeni İçerik</b>";
console.log(document.all[12]);

// Belirli bir indexteki elementi alma ve stilini değiştirme
sonuc=document.all[20].style;
console.log(sonuc);     
document.all[20].style.fontSize="30px";
document.all[20].style.color="blue";
console.log(document.all[20]);

// Belirli bir indexteki elementi alma ve sınıf ekleme          
sonuc=document.all[25].classList;
console.log(sonuc);
document.all[25].classList.add("yeni-sinif");
console.log(document.all[25]);  
// Belirli bir indexteki elementi alma ve sınıf kaldırma
sonuc=document.all[25].classList;
console.log(sonuc);
document.all[25].classList.remove("yeni-sinif");
console.log(document.all[25]);  


// sadik 
sonuc=document.URL;
console.log(sonuc);
    

sonuc=document.forms;
sonuc=document.forms[0];
console.log(sonuc);

sonuc=document.forms[0].method;
console.log(sonuc);

sonuc=document.forms[0].action;
console.log(sonuc);
 

// itenilen etiketin içindeki id i yi değiştirebiliriz
document.all[7].id="degistirilenId";
console.log(document.all[7]);  

// itenilen etiketin içindeki class ı değiştirebiliriz

