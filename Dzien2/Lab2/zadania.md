## Zadanie 1 - IP Address

Celem tego zadania jest nauka korzystania z publicznych modułów.

W tym zadaniu należy stworzyć 2 zasoby zewnętrznych adresów IP wykorzystując moduł: 
https://registry.terraform.io/modules/terraform-google-modules/address/google/latest.
Podczas tworzenia adresów wstaw odpowiednie parametry aby stworzyc zasób w Twoim pojekcie,
w regionie, którego uzywasz dla większości zasobów oraz wskaz odpowiedni rodzaj adresu.
Nazwy zasobów mogą byc dowolne. Powstałe adresy wyświetl za pomoca bloku `output`.
 
Aby zrealizować to zadanie, należy wykonać następujące kroki:
1. Utwórz nowy plik i nazwij go np. `vm.tf` - adresy wykorzystamy dalje do tworzenia maszyny wirtualnej.
2. W nowym pliku stwórz blok module i korzystając z dokumentacji utwórz 2 nowe adresy IP.
3. Podczas tworzenia adresów wstaw odpowiednie parametry aby stworzyc zasób w Twoim pojekcie, w regionie, którego używasz dla 
   większości zasobów oraz wskaz odpowiedni zewnętrzny rodzaj adresu.
4. Uruchom polecenie `terraform init` aby zinicjalizować moduł wykorzystywany w zadaniu.
5. Standardowo uruchom polecenia `terraform plan` aby zweryfikować swoją konifgurację oraz `terraform apply` aby wdrożyć zmiany.
6. Sprawdź w portalu zasoby utworzone za pomoca modułu.
7. Utwórz blok output w którym jako wartość przekażesz powstałe adresy IP. Sprawdź w dokumentacji jaką nazwę output'u wskazać aby się do nich odwołać.

Pomocne linki:

* [Publiczny moduł compute](https://registry.terraform.io/modules/terraform-google-modules/address/google/latest)

## Zadanie 2 - VPC/Peering

Celem tego zadania jest nauka tworzenia i wykorzystania własnych modułów.

W ramach tego zadania należy utworzyć moduł składający się z pojedynczej sieci VPC, połączonej peeringiem z siecią 
`vpc-shared` stworzoną w poprzednich zadaniach. Pamiętaj, że peering należy skonfigurować w 2 strony, czyli zarówno 
od tworzonej w module sieci jak i od sieci `vpc-shared`. Za pomoca modułu nalezy stworzyć sieci dla 2 środowisk: *dev* oraz *prod*.

Zdefiniuj w module pojedynczą zmienną:
* env - nazwa środowiska, które będzie reprezentować sieć  

Aby zrealizować to zadanie, należy wykonać następujące kroki:

1. Utwórz nowy folder, który przeznaczysz na stworzenie kodu modułu. Dobrą praktyką będzie nadanie mu takiej nazwy, która
   pozwoli zidentyfikować że jest to moduł służący do powoływania sieci vpc.
2. W nowym folderze zacznij od stworzenia pliku `providers.tf`, w którym zdefiniujesz dostawce potrzebnego do napisania kodu modułu. 
   Ponieważ provider może byc przekazany z poziomu, na którym wywoływany będzie moduł, wystarczy konfiguracja bloku `required_providers`.
   W tym celu najprościej będzie skopiować obecny już plik *providers.tf*. Blok provider nie będzie w tym przypadku konieczny, ponieważ domyślnie
   zostanie wykorzystany provider zdefiniowany w głównym katalogu, z którego korzystaliśmy do tej pory.
3. Stwórz plik `variables.tf` ze zmienną wymienioną na początku zadania. Nadaj jej odpowiedni typ czyli zwykły`string`.
4. Stwórz plik `main.tf`, w którym zdefiniujesz wszystkie zasoby wymiemione w treści zadania.
5. Stwórz zasób sieci, oraz 2 zasoby pering'u z siecią `vpc-shared`. Sieć będzie odpowiadać poszczególnym środowiskom, dlatego możesz 
   nadać jej nazwę w Terraformie jako "env" np. `resource "google_compute_network" "env"`. Nazwa samego zasobu powinna zawierać nazwę środowiska, 
   dlatego należy w niej umieścić odniesienie do zmiennej. Nazwa peering'u również powinna zawierać zmienną użytą do nadania nazwy sieci. 
   Pozwoli to udynamicznić moduł i w konsekwencji użyć go do tworzenia sieci dla wielu środowisk.
6. W celu odwołania się do atrybutu *self_link* dla sieci `vpc-shared` (co jest potrzebne do konfiguracji peering'u) skorzystaj z bloku typu data,
   za pomoca którego pobierzesz informacje odnośnie wspomnianej sieci.
7. W katalogu modułu stwórz również plik `outputs.tf`, a w nim blok output, w którym jako wartość przekażesz cały zasób sieci.
8. W głównym katalogu, w którym stworzysz kod do pozostałych zadań przejdź do pliku od sieci lub stwórz nowy plik np. `network-env.tf`.
9. Zefiniuj wywołanie modułu, który stworzyłeś/aś. Pamiętaj o wskazaniu źródła (source), czyli ścieżki do folderu, w którym skonfigurowałeś/aś kod modułu. 
   Pamiętaj również o przypisaniu wartości do zmiennej zdefiniowanej wewnątrz modułu. Terraform będzie potrzebował tej wartości aby wywołać moduł. Spróbuj wywołać
   moduł 2 razy: odpowiednio dla środowisk *dev* oraz *prod*.
10. Standardowo uruchom polecenia `terraform init` aby zinicjalizować moduł, `terraform plan` aby zweryfikować swoją konifgurację oraz `terraform apply` aby wdrożyć zmiany.
11. Sprawdź konfigurację stworzonych zasobów. Spróbuj odnaleźć je w pliku stanu. Zwróć uwagę jak wygląda ich referencja.
12. *** Zwróć uwagę na to, że nowy moduł, podobnie jak w przypadku zwykłego zasobu sieci vpc, potrzebuje włączonego odpowiedniego API aby móc
   powołać zasoby sieci. Na tym etapie pisania kodu ten fakt może łatwo umknąć uwadze dewelopera ale w przypadku odtwarzania całej infarstruktury od zera
   brak zależności prawdopodobnie będzie skutkowac błędem. W tym celu wykorzystaj argument `depends_on` aby obłużyć taki scenariusz.

Pomocne linki:

* [Zasób google_compute_network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network)
* [Zasób google_compute_network_peering](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network_peering)

## Zadanie 3 - Compute Instance

Celem tego zadania jest nauka tworzenia i wykorzystania własnych modułów.

W ramach tego zadania należy utworzyć moduł służący do powoływania maszyny wirtualnej wraz z przypisanym jej Service Account.
Maszyny mogą byc wykorzystane np. jako jumphost w sieci `vpc-shared` i powinny wykorzystać zewnętrzny adres IP stworzony
za pomoca publicznego modułu z zadania 1.

Zdefiniuj w module następujące zmienne:
* identifier      - numer lub nazwa identyfikująca daną maszynę wirtualną
* subnetwork_name - nazwa podsieci do której będzie przypięty interfejs maszyny
* ip              - zewnętrzny adres IP, który będzie przypisany do maszyny wirtualnej

Aby zrealizować to zadanie, należy wykonać następujące kroki:

1. Utwórz nowy folder, który przeznaczysz na stworzenie kodu modułu. Podobnie jak w poprzednim zadaniu nadaj mu odpowiednią nazwę.
2. Zacznij od stworzeniu plików `providers.tf` oraz `variables.tf` gdzie zdefiniujesz wszystkie zmienne wymienione powyżej w treści zadania.
3. W głównym pliku modułu, np. `main.tf`, zapisz definicje potrzebnych zasobów: Service Acccount oraz Compute Instance. Udynamicznij nazwy zasobów 
   poprzez wykorzystanie zmiennej *identifier*. Za pomocą pozostałych zmiennych, zadbaj o podłączenie maszyny do odpowiedniej podsieci oraz przypisanie
   jej zewnętrznego adresu IP. Zapisz również powiązanie Service Account z maszyną wskazując adres email tożsamości. Jako zarkes (scope) wskaż *"cloud-platform"*.
   Ponadto użyj konkretnego obrazu - *e2-medium* oraz rozmiaru maszyny - *e2-medium*.
4. W końcu stwórz plik `outputs.tf`, w którym przekażesz zasób maszyny.
5. W głównym katalogu skorzystaj z pliku `vm.tf`, w którym wywołujesz swój moduł. Dodaj stworzone w tym zadaniu zmienne w postaci 
   argumentów do wywoływanego modułu i przypisz im odpowiednie wartości: jako podsieć wskaż stworzoną już podsieć *jumphost*, a jako *ip*
   wskaż jeden z zewnętrznych adresów stworzonych w zadaniu 1 z wykorzytsaniem modułu publicznego.
6. Standardowo uruchom polecenia `terraform init` aby zinicjalizować moduł, `terraform plan` aby zweryfikować swoją konifgurację oraz `terraform apply` aby wdrożyć zmiany.
7. *** Jeśli moduł działa prawidłowo, możesz spróbować wowyłać moduł w pętli `count` lub `for_each` analogicznie jak w przypadku zwykłych zasobów.
   Możesz np. iterować po zewnętrznych adresach IP stworzonych w zadaniu 1.

   Pomocne linki:

* [Zasób google_compute_instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance)
* [Zasób google_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account)
