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

## Zadanie 3 - Subnet/Network Security Group

Celetem tego zadania jest nauka tworzenia i wykorzystania bardziej rozbudowanych modułów.

W ramach tego zadania należy rozbudować moduł stworzony w poprzednim zadaniu. Dla tworzonej sieci należy zdefiniować
3 podsieci: `app`, `data` oraz `endpoint`. Ponadto podsieć `data` powinna być skonfigurowana z tzw. service delegation
dla usługi `Microsoft.DBforPostgreSQL/flexibleServers`.
Dodatkowo do każdej z podsieci powinna być stworzona i przypięta osobna instancja Network Security Group.

Twój moduł powinien zawierać następujące zmienne:
* vnet_name             - nazwa tworzonej sieci  
* vnet_address_space    - zarkes adresacji tworzonej sieci
* rg_name               - nazwa wykorzystywanej w kursie resource grupy
* location              - lokalizacja wykorzystywanych w kursie zasobów (np. z resource grupy)
* id-vnet-shared        - id sieci stworzonej w jednym z poprzednich zadań
* name-vnet-shared      - nazwa sieci stworzonej w jednym z poprzednich zadań
* sub_app_address_space - zarkes adresacji tworzonej podsieci `app`
* sub_data_address_space - zarkes adresacji tworzonej podsieci `data`
* sub_endpoint_address_space - zarkes adresacji tworzonej podsieci `endpoint`

Aby zrealizować to zadanie, należy wykonać następujące kroki:

1. Owtórz folder, w którym trzymasz kod modułu z poprzedniego zadania
2. Uzupełnij plik `variables.tf` o brakujące zmienne potrzebne do stworzenia podsieci.
3. W następnym kroku zdefiniuj tworzenie 3 wskazanych podsieci: `app`, `data` oraz `endpoint`. Ponieważ podsieć `data` powinna 
   posiadać tzn. service delegation dla usługi PostgreSQL Flexible Server, należy wykorzystać blok `delegation` oraz 
   `service_delegation`. Oprócz wskazania usługi `Microsoft.DBforPostgreSQL/flexibleServers`, konieczne będzie też nadanie 
   nastęoującej akcji: `Microsoft.Network/virtualNetworks/subnets/join/action`.
4. Na końcu zdefiniuj 3 zasoby Network Security Group, po jednym dla każdej podsieci. Następnie połącz NSG z odpowiednimi
   podsieciami. Nazwy zasobów NSG również powinny zawierać zmienną użytą do nadania nazwy sieci. Tak jak w przypadku peering'u, 
   pozwoli to udynamicznić moduł i w konsekwencji użyć go do tworzenia sieci dla wielu środowisk.
5. W głównym katalogu, w pliku `network-env.tf`, w którym wywołujesz swój moduł, dodaj stworzone w tym zadaniu zmienne w postaci 
   argumentów do wywoływanego modułu. Przypisz im odpowiednie wartości.
6. Standardowo uruchom polecenia `terraform plan` aby zweryfikować swoją konifgurację oraz `terraform apply` aby wdrożyć zmiany.
7. Jeśli moduł działa prawidłowo, stwórz za jego pomocą 2 sieci (z zasobami zdefiniowanymi w module) odpowiadające odpowiednio
   środowisku `dev` oraz `prod`. Nazwa środowiska powinna być zawarta w nazwie tworzonych sieci.

   Pomocne linki:

* [Zasób Subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet)
* [Zasób Network Security Group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/network_security_group)
* [Zasób NSG Association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association)


## Zadanie 4 - Private Endpoint: Key Vault

Celem tego zadania jest nauka przekazywania danych wyjsciowych z modułu oraz ich wykorzystanie w głównym katalogu z kodem.

W tym zadaniu należy postawić zasoby Private Endpoint dla stworzonego wcześniej Kay Vault'a. W tym celu należy
wykorzystać sieć stworzoną w poprzednim zadaniu i przynależną do środowiska `dev`. Any umożliwić wykorzystanie tej sieci w 
głównym katalogu, potrzebne będzie zdefiniowanie danych wyjściowych w module za pomocą których należy przekazać zasób podsieci.

Aby zrealizować to zadanie, należy wykonać następujące kroki:

1. W katalogu z kodem Twojego modułu stwórz nowy plik z kodem Terraform i nazwij go `outputs.tf`
2. W nowym pliku stwórz blok wyjścia i przekaż za jego pomocą caly zasób podsieci `endpoint`.
3. W katalogu głównym zdefiniuj zasób Private Endpoint dla Azure Key Vault. Ponieważ chcemy wykorzystać Private Endpoint dla
   usługi Key Vault nadaj argumentowi `subresource_names` odpowiednią wartość. Wskaż również właściwą prywatną strefę DNS dla 
   zasobu Key Vault. Jako podsieć wskaż podsieć `endpoint` przekazywaną z modułu za pomocą bloku utworzonego w poprzednim punkcie.
4. Standardowo uruchom polecenia `terraform plan` aby zweryfikować swoją konifgurację oraz `terraform apply` aby wdrożyć zmiany.

Pomocne linki:

* [Terraform Outputs](https://developer.hashicorp.com/terraform/language/values/outputs)
* [Dostępne nazwy zasobów podrzędnych](https://learn.microsoft.com/en-gb/azure/private-link/private-endpoint-overview#private-link-resource)
* [Dokumentacja zasobu private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint)

## Zadanie 5 - Private Endpoint: File Share (Zadanie opcjonalne)

Jeśli udało Ci sie prawodłowo skonfigurować endpoint dla usługi Key Vault, spróbuj zrobić to samo, tym razem dla File Share,
utworzonego w poprzednich zadaniach.

Pomocne linki:

* [Terraform Outputs](https://developer.hashicorp.com/terraform/language/values/outputs)
* [Dostępne nazwy zasobów podrzędnych](https://learn.microsoft.com/en-gb/azure/private-link/private-endpoint-overview#private-link-resource)
* [Dokumentacja zasobu private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint)

## Zadanie 6 - PrivateDNS Zones

W tym zadaniu należy przypiąć wszystkie stworzone wcześniej prywatne strefy DNS do nowych sieci środowisk `dev` oraz `prod`.

Na co warto zwrócić uwagę:
* Aby przypiąć DNS private zone do sieci, potrzebne jest jej id. Skonfiguruj dostęp do zasobu sieci, dodając dla niego blok
   w pliku `outputs.tf` znajdującym sie w folderze modułu.
* Analogicznie jak w przypadku sieci `vnet-shared`, udynamicznij nazwę połączenia łącząc nazwę strefy lub jej klucz w zmiennej
  lokalnej z nazwą sieci do której tworzone jest połączenie.
* Wykorzystaj pętlę `for_each` jak w przypadku sieci shared.

Pomocne linki:

* [Terraform Outputs](https://developer.hashicorp.com/terraform/language/values/outputs)
* [Dokumentacja zasobu private_dns_zone_virtual_network_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link)

## Zadanie 7 - PostgreSql Flexible Server (Zadanie opcjonalne)

W ramach tego zadania należy utworzyć PostgreSql Flexible Server i przypiąć go do zdelegowanej dla tej usługi podsieci `data`,
przynależnej do sieci środowiska `dev`. Skonfiguruj równiez odpowiednią dla tej usługi strefę DNS. Zdefiniuj w kodzie login oraz
hasło administratora servera. Dodatkowo wskaż następujące argumenty i wskazane wartości:

  sku_name   = "B_Standard_B1ms"
  version    = "12"
  storage_mb = 32768
  zone       = "1"

Pomocne linki:

* [Terraform Outputs](https://developer.hashicorp.com/terraform/language/values/outputs)
* [Dokumentacja Postgresql Flexible Server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server)

## Zadanie 8 - Provider Random (Zadanie opcjonalne)

Spróbuj użyć providera `random` do stworzenia zasobu `random_password` i wykorzystaj go do nadania hasła administratora serwera
PostgreSql. Samemu wyszukaj informacji nt. jak używać tego dostawcy i zasobu.

## Zadanie 9 - AKS Idetities & Roles

W tym zadaniu należy stworzyć 2 tożsamości wykorzystywane przez AKS oraz nadać im odpowiednie Role na poszczególnych zasobach.

Wymagania:
* Tożsamość `cni_kubelet` z następującą rolą:
   - `AcrPull` na zasobie Azure Container Registry
* Tożsamość `cni` z następującymi rolami:
   - `Private DNS Zone Contributor` na zasobie prywatnej strefy DNS dla Azure Kubernetes Service
   - `Contributor` na zasobie Twojej grupy zasobów
   - `Managed Identity Operator` na zasobie drugiej z tworzonych tożsamości

Pomocne linki:

* [Dokumentacja User Assigned Identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity)
* [Dokumentacja Role Assigment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment)

## Zadanie 10 - AKS Cluster

W tym zadaniu należy stworzyć klaster Azure Kubernetes Service wykorzystujący tożsamości stworzone w zadaniu poprzednim oraz 
zintegrowany z podsiecią `app` w środowisku (sieci) `dev`. Oprócz podstawowych argumentów, definiowany zasób powinien
posiadać następujące wartości:

   ```terraform
   dns_prefix                          = "aks-app-dev"
   private_cluster_enabled             = true
   private_cluster_public_fqdn_enabled = true
   private_dns_zone_id                 = "------ID prywatnej strefy DNS dla usługi AKS------"

   default_node_pool {
     name           = "system"
     node_count     = 1
     vnet_subnet_id = "------ID podsieci wskazanej w treści zadania------"
     vm_size        = "Standard_B2s"
   }

   identity {
     type         = "UserAssigned"
     identity_ids = ["------ID tożsamości cni------"]
   }

   kubelet_identity {
     client_id                 = "------client_id tożsamości cni_kubelet------"
     object_id                 = "------principal_id tożsamości cni_kubelet------"
     user_assigned_identity_id = "------ID tożsamości cni_kubelet------"
   }
   ```

Pomocne linki:

* [Dokumentacja Azure Kubernetes Service](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster)

## Zadanie 11 - CI/CD dla Terraform w Azure DevOps (Zadanie opcjonalne)

Celem tego zadania jest nauka wykorzystania potoków CI/CD do tworzenia infrastruktury za pomocą Terraform w Azure DevOps.

> UWAGA: Do wykonania zadania potrzebny jest dostep do własnej organizacji w Azure DevOps oraz odpowiednie uprawnienia. Bieżący kurs nie przewiduje nadania dostępów dla kursantów dla środowisk Azure DevOps.**

> WAŻNE: Jeśli chcesz wykorzystać w pełnii demo przedstawione w pliku **azure-pipelines-approval.yml**, musisz wykonać dodatkowy krok w postaci stworzenia tzw. Environment w Azure DevOps- [LINK](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/environments?view=azure-devops). Jeśli nie chcesz wprowadzać żadnych zmian w pliku YAML, nazwij tworzony Environment jako **'ExecutePlan'**

W tym zadaniu należy stworzyć potok CI/CD w Azure DevOps dla infrastruktury utrzymywanej za pomocą kodu Terraform, który będzie umożliwiał automatyczne tworzenie lub aktualizowanie zasobów w chmurze Azure. Potok powinien składać się z dwóch faz: Continuous Integration (CI) i Continuous Deployment (CD), zdefiniowanych w pliku konfiguracyjnym azure-pipelines.yml. Przykładowy plik ten znajduje się w bieżącej ścieżce repozytorium (Dzien2/Lab2/Zadanie11).

Aby zrealizować to zadanie, należy wykonać następujące kroki:

W środowisku Azure:

1. Przejdź do usługi Azure Active Directory i utwórz Service Principal z domyślnymi ustawieniami.
2. Zapisz "Application (client) ID" z zakładki Overview Service Principal w celu wykorzystania go podczas konfiguracji połączenia z Azure w Azure DevOps.
3. Wygeneruj "Client secret" dla Service Principal w zakładce Certificates & Secrets i zapisz go w bezpiecznym miejscu, aby użyć go później w Azure DevOps.
4. Nadaj rolę RBAC o nazwie "Owner" dla Service Principal na poziomie wybranej subskrypcji lub grupy zasobów.
5. Przejdź do środowiska Azure DevOps.

W środowisku Azure DevOps:

1. Utwórz nowe repozytorium lub projekt dla kodu Terraform w Azure DevOps.
2. Skonfiguruj połączenie z Azure w Azure DevOps, umożliwiając dostęp do zasobów w chmurze:
* Przejdź do Project `Settings`/`Service Connections`/`New Service connection`,
* Wybierz opcję z `Azure Resource Manager`/`Service principal (manual)`,
* Uzupełnij wymagane informacje:
   - Scope Level - zaznacz "Subscription",
   - Subscription Id - możesz pobrać z portalu przechodząc do wybranej subskrypcji oraz następnie do zakładki "Overview". Znajdziesz tam pole "Subscription ID",
   - Service principal Id - wskaż zapisany w krokach wcześniejszych "Application (client) ID",
   - Service principal key - wskaż pobrany "Client secret",
   - Zaznacz "Grant access permission to all pipelines".
3. Utwórz plik konfiguracyjny "azure-pipelines.yml" w repozytorium, który będzie zawierał definicję potoku CI/CD - dla terraform będzie to kolejno init, plan, apply. Jeśli potrzebujesz pomocy, skorzystaj z gotowego przykładu w repozytorium zadania.
4. Utwórz nowy potok Azure Pipelines:
* Z pozycji gównego menu po lewej stronie portalu wybierz `Azure Pipeline`/`New pipeline`/`Azure Repos Git`
* Wybierz stworzone przez Ciebie repozytorium, gdzie istnieje plik ze zdefiniowanym potokiem np. `azure-pipelines.yml`:
   - Wskaż opcję `Existing Azure Pipelines YAML File`,
   - Następnie z menu w sekcji "Path" wskaż stworzony plik z repozytorium.

Pomocne linki:

* [Tworzenie projektu w usłudze Azure DevOps](https://learn.microsoft.com/en-us/azure/devops/organizations/projects/create-project?view=azure-devops&tabs=browser)
* [Używanie komend Terraform dla Azure DevOps](https://github.com/microsoft/azure-pipelines-terraform/blob/main/Tasks/TerraformTask/TerraformTaskV4/README.md)
