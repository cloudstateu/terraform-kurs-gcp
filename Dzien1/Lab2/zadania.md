#  Zadania z bieżącego oraz kolejnych laboratoriów wykonuj w folderze/konfiguracji Terraform z Lab1 Zadanie2

## Zadanie 1 - Cloud Storage

Celem tego zadania jest nauczenie się importowania zasobów do stanu.

W ramach tego zadania należy utworzyć zasób Cloud Storage (Bucket) ręcznie w GCP, przygotować kod Terraform reprezentujący
dany zasób i zaimportować zasób do stanu przy pomocy polecenia `terraform import`.

Aby zrealizować to zadanie, należy wykonać następujące kroki:

1. Utwórz zasób Cloud Storage w portalu GCP. Wskaż `europe-west1` jako region dla tworzonego zasobu.
2. Przygotuj reprezentacje Bucket'a w nowym pliku Terraform nazwanym `storage.tf`.
3. Zaimportuj utworzony zasób przy pomocy polecenia `terraform import`.
4. Sprawdź zmiany w pliku stanu po zaimportowaniu zasobu.
5. Uruchom polecenie `terraform plan` w celu sprawdzenia zgodności opisanego zasobu ze znajdującym się w chmurze.

Pomoce linki:
* [Zasób google_storage_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket)
* [Polecenie terraform import](https://developer.hashicorp.com/terraform/cli/commands/import)


## Zadanie 2 - Cloud Secret Manager

Celem tego zadania jest nauczenie się tworzenia zasobów w chmurze GCP przy użyciu Terraform.

W ramach tego zadania należy dodać do konfiguracji z zadania poprzedniego tworzenie nowego zasobu Google Cloud Secret Manager Secret w projekcie pobranym
przy pomocy bloku data.

Aby zrealizować to zadanie, należy wykonać następujące kroki:

1. Przed rozpoczęciem ćwiczenia należy włączyc odpowiednie API na poziomie projektu. W tym celu wywołaj następująca komende uzupełniajac odpowiednią nazwe 
   projektu `gcloud services enable secretmanager.googleapis.com --project prj-studentXX`
2. W nowo utworzonym pliku `secrets.tf`skonfiguruj blok zasobu dla usługi Google Cloud Secret Manager Secret. Podczas konfigurowania zasobu wykorzystaj w 
   odpowiednim argumencie referencje do projektu pobieranego za pomoca bloku data. Postaraj się stworzyć jak najprostszą definicje sekretu na podstawie 
   przykładów z dokumentacji.
3. Uruchom polecenie `terraform plan`. Sprawdź, czy Terraform wykrył błędy w konfiguracji. Zwróć uwagę na wynik planu - Terraform powinien zwrócić plan 
   utworzenia jednego nowego zasobu.
4. Uruchom polecenie `terraform apply`, aby wdrożyć zasób Secret.
5. Zweryfikuj, czy utworzenie zasobu przebiegło pomyślnie przez wyszukanie zasobu w portalu GCP.
6. Sprawdź, jakie zmiany powstały w pliku stanu, zwróć uwagę na różnice pomiędzy `data` a `resource`.

Pomocne linki:

* [Zasób google_secret_manager_secret](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret)


## Zadanie 3 - Virtual Private Cloud (VPC) Shared network

Celem tego zadania jest nauczenie się korzystania ze zmiennych.

W ramach tego zadania należy stworzyć sieć wirtualną `vpc-shared` oraz podsieć `jumphost` przy pomocy zasobów 
`google_compute_network` oraz `google_compute_subnetwork`. W tym celu włącz również odpowiednie API za pomocą zasobu
`google_project_service`. Nazwy zasobów i zakres podsieci umieść w zmiennych. Wykorzystaj zmienną lokalną do wymuszenia 
prefixu w nazwach zasobów z Twoim numerem studenta. Zasoby umieść w przygotowanej dla Ciebie projekcie.

Aby zrealizować to zadanie, należy wykonać następujące kroki:

1. Utwórz plik `variables.tf` i zdefiniuj w nim zmienne typu string: `vpc_shared_name`, `sbn_jh_name` oraz `sbn_jh_range`.
2. Dodaj do pliku `variables.tf` zmienną lokalną `prefix`, która będzie zawierać całą nazwę lub sam numer Twojego kursanta. Wykorzystasz go jako prefix dodawany
   na początku lub końcu nazw tworzonych zasobów.*
3. Utwórz plik `network.tf` i stwórz w nim definicje zasobu `google_project_service`. Wykorzystaj go do włączenia API `compute.googleapis.com` na poziomie 
   swojego projektu. Dzięki temu będziesz mógł powołać m.in. zasoby sieciowe.
4. Dodaj definicje potrzebnych zasobów sieciowych tj. `google_compute_network` i `google_compute_subnetwork`. Skonfiguruj je z wykorzystaniem zmiennych oraz 
   zmiennych lokalnych. Dodaj zależność pomiędzy zasobem VPC oraz włączeniem serwisu (API) z poprzedniego punktu. W tym celu wykorzystaj argument `depends_on`. Zasób
   podsieci nie potrzebuje tej zależności ponieważ przy dynamicznym wskazaniu sieci automatycznie zostanie od niej uzależniony.
5. Utwórz plik `terraform.tfvars` i przypisz wartości do każdej zmiennej.
6. Uruchom polecenie `terraform plan`. Sprawdź, czy Terraform wykrył błędy w konfiguracji.
7. Uruchom polecenie `terraform apply`, aby powołać nowe zasoby.
8. Spróbuj przekazać wartość zmiennej do konfiguracji Terraform na inne sposoby np. z poziomu opcji CLI -var, zmiennych
   środowiskowych TF_VAR_. Spróbuj przekazać wartość na kilka sposób jednocześnie i sprawdź efekt.*


Pomocne linki:

* [Zasób google_project_service](https://registry.terraform.io/providers/hashicorp/google/5.43.1/docs/resources/google_project_service)
* [Zasób google_compute_network](https://registry.terraform.io/providers/hashicorp/google/5.43.1/docs/resources/compute_network)
* [Zasób google_compute_subnetwork](https://registry.terraform.io/providers/hashicorp/google/5.43.1/docs/resources/compute_subnetwork)
* [Zmienne w terraform](https://developer.hashicorp.com/terraform/language/values/variables)
* [Pierwszeństwo definicji zmiennych](https://developer.hashicorp.com/terraform/language/values/variables#variable-definition-precedence)


## Zadanie 4 - Filestore (Zadanie opcjonalne)

Należy zdefiniować utworzenie instancji Google Cloud Filestore.
Azure Storage File Share zostanie podłączony do naszej aplikacji w celu przechowywania plików.

Na co warto zwrócić uwagę:

* Wykorzystaj istniejący plik `storage.tf` lub stwórz nowy, dedykowany dla zasobu File Share.
* Podczas tworzenia File Share wybierz Quota: 50gb.
* Zasób ten będzie dedykowany dla środowiska aplikacji.

Pomocne linki:

* [Dokumentacja Storage Account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)
* [Dokumentacja Storage Share](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share)

## Zadanie 5 - Container Registry

W ramach tego zadania należy utworzyć Azure Container Registry, w którym przechowywane będą obrazy aplikacji.

Na co warto zwrócić uwagę:

* Stwórz nowy plik i nazwyj go np. `acr.tf`.
* ACR będzie współdzielony pomiędzy środowiskami, dlatego w kolejnych zadaniach będzie umieszczony w sieci Shared,
* Podczas tworzenia zasobu wybierz sku: `Premium`, tylko w tym planie jest dostępna możliwość komunikacji prywatnej.
* Stwórz zasób z włączoną opcją użytkownika typu administrator definiując odpowiedni argument wraz z wartością.
* Zablokuj dostep publiczny do tworzonej usługi definiując odpowiedni argument wraz z wartością.

Pomocne linki:

* [Dokumentacja zasobu azurerm_container_registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry)

## Zadanie 6 - DNS Zone/Private Endpoint

W tym zadaniu utworzymy private endpoint dla Azure Container Registry, tak aby usługa wykorzystywała do komunikacji sieć prywatną.

Przed przystąpieniem do utworzenia private endpoint, należy utworzyć prywatną strefę DNS oraz powiązać ją z siecią wirtualną.
Nazwę strefy DNS przekaż w formie zmiennej lokalnej. Użyj zmiennej, w postaci mapy `map(string)`, w której kluczem będzie skrócona nazwa usługi,
a wartością nazwa strefy DNS.
Prywatne strefy DNS wykorzystywane przez private endpoint powinny korzystać z zalecanych nazw.

Przykład zmiennej lokalnej typu `map(string)`:

```terraform
locals {
  zones = {
    "file"       = "privatelink.file.core.windows.net"
    "postgresql" = "privatelink.postgres.database.azure.com"
  }
}
```

Na co warto zwrócić uwagę:

* Dla przejrzystości kodu, utwórz nowe dedykowane pliki np. `dns.tf` oraz `endpoints.tf`.
* W bloku `private_service_connection` podczas tworzenia private endpoint, należy wskazać id zasobu, dla którego
  tworzymy endpoint oraz nazwę zasobu podrzędnego. Wyszukaj jej wartość w dokumentacji.
* W bloku `private_dns_zone_group` podczas tworzenia private endpoint należy wskazać id prywatnej strefy dns, dzięki temu
  odpowiedni rekord A wskazujący na interfejs sieciowy endpointu zostanie automatycznie dodany.
* W parametrze `subnet_id` podczas tworzenia private endpoint należy wskazać podsieć przeznaczoną na private endpoint.
   będzie to podsieć `endpoints`w sieci `vnet-shared`.

Pomocne linki:

* [Zalecane nazwy prywatnych stref dns](https://learn.microsoft.com/pl-pl/azure/private-link/private-endpoint-dns#azure-services-dns-zone-configuration)
* [Dostępne nazwy zasobów podrzędnych](https://learn.microsoft.com/en-gb/azure/private-link/private-endpoint-overview#private-link-resource)
* [Dokumentacja zasobu private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint)
* [Dokumentacja zasobu private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone)
* [Dokumentacja zasobu private_dns_zone_virtual_network_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link)