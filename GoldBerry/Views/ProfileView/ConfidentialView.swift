import SwiftUI

struct ConfidentialView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Text("Политика конфиденциальности\nперсональных данных")
                    .font(Font(uiFont: .fontLibrary(25, .uzSansBold)))
                    .foregroundColor(.black)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .padding()
                Text("""
                     Настоящее Положение о конфиденциальности персональных данных (далее – Положение) разработано ИП «Кутовенко Г.В.», действующего на основании Устава, и содержит в себе базовые нормы обработки, хранения и передачи персональных данных пользователей в рамках Интернет Сервиса GoldBerry.
                     Настоящее Положение о конфиденциальности персональных данных разработано в строгом соответствии с  Законом Республики Беларусь № 99-3 «О защите персональных данных», а также другими нормативно-правовыми документами, которые регулируют порядок обработки персональных данных пользователей, в том числе в сети Интернет посредством Интернет Сервиса.
                     1. ТЕРМИНЫ И ОПРЕДЕЛЕНИЯ
                     В рамках настоящего Положения термины и определения используются в следующем значение:
                     1.1. Интернет Сервис - совокупность программных и аппаратных средств для ЭВМ, обеспечивающих публикацию для всеобщего обозрения информации и данных, объединенных общим целевым назначением, посредством технических средств, применяемых для связи между ЭВМ в сети Интернет. Сервис доступен Пользователям по уникальному электронному адресу или его буквенному обозначению. Под Сервисом в настоящем Положении понимается Интернет Сервис, расположенный в цифровом магазине.
                     1.2. Администрация Сервиса - представители Сервиса, которые уполномочены владельцем Сервиса на управление Сервисом и контролем, над его функционированием в рамках настоящего Положения, а также других документов, которые регулируют отношения между Администрацией Сервиса и Пользователями Сервиса.
                     1.3. Пользователь Сервиса – лицо, которое использует Сервис, исключительно способом регламентированным настоящим Положением и другими документами, которые регулируют взаимоотношение между Пользователем и Сервисом (Администрацией Сервиса).
                     1.4. Регистрация в Сервисе – процедура внесения персональных данных Пользователя в специальную форму на страницах Сервиса. При этом Пользователь становится зарегистрированным.
                     1.5. Персональные данные Пользователя – любая информация, относящаяся к прямо или косвенно определенному или определяемому лицу (субъекту персональных данных), которое использует Сервис.
                     1.6. Обработка персональных данных Пользователей Сервиса – любое действие (операция) или совокупность действий (операций), совершаемых Администрацией Сервиса с использованием средств автоматизации или без использования таких средств с персональными данными, включая сбор, запись, систематизацию, накопление, хранение, уточнение (обновление, изменение), извлечение, использование, передачу (распространение, предоставление, доступ), обезличивание, блокирование, удаление, уничтожение персональных данных лиц, которые используют Сервис.
                     1.7. Файлы Cookies Сервиса – небольшие фрагмент данных, отправленных интернет сервером и хранимые на компьютере (любом другом устройстве Пользователя, посредством которого осуществляется вход в Сервис) Пользователя, который веб-клиент или веб-браузер каждый раз пересылает интернет серверу в HTTP-запросе при попытке открыть страницы Сервиса.
                     1.8. IP-адрес – уникальный сетевой адрес узла в компьютерной сети, построенной по протоколу IP.
                     2. ОБЩИЕ ПОЛОЖЕНИЯ
                     2.1. Нормы настоящего Положения действуют в отношении любой информации (персональных данных), которая может стать известной Администрации Сервиса в процессе использования Сервиса Пользователями, в том числе в процессе прохождения ими процедуры регистрации.
                     2.2. Использование Сервиса (в любом объеме, форме и т.д.) означает полное согласие такого Пользователя с условиями настоящего Положения и порядком обработки персональных данных такого Пользователя в процессе оказания услуг Сервисом.
                     2.3. Любые действия Пользователя в рамках Сервиса признаются Администрацией Сервиса услугами информационного характера.
                     2.4. Акцептом настоящего Положения конфиденциальности является использование Сервиса и заполнение регистрационных данных.
                     2.5. В случае если Пользователь не согласен с нормами, которые содержатся в настоящем Положении, он обязан прекратить использование Сервиса. Любое использование Сервиса Пользователем означает его полное согласие и принятие всех условий настоящего Положения.
                     2.6. Настоящее Положение применяется только к Сервису. Администрация Сервиса не контролирует и не несет ответственность за интернет ресурсы третьих лиц, на которые Пользователь может перейти по ссылкам, доступным на страницах Сервиса.
                     2.7. Администрация Сервиса не проверяет достоверность персональных данных, предоставляемых Пользователем Администрации Сервиса (в момент регистрации), но оставляет за собой право мониторинга достоверности таких персональных данных.
                     2.8. В случае, если одно или несколько положений настоящего Положения утратит свою силу или окажется недействительным, или не имеющим юридической силы, это не оказывает влияния на действительность или применимость остальных положений настоящего Положения.
                     2.9. Пользователь несет персональную ответственность за проверку настоящего Положения на наличие изменений в нем. Администрация Сервиса оставляет за собой право по своему личному усмотрению изменять или дополнять настоящее Положение в любое время без предварительного и последующего уведомления. Администрация Сервиса будет публиковать такие изменения и/или дополнения в данном приложении. Дальнейшее использование Пользователем Сервиса, после любых подобных изменений, означает полное согласие такого Пользователя с такими изменениями и дополнениями.
                     2.10. Регистрируясь в Сервисе, Пользователь согласен с тем, что:
                     - регистрационные данные (в том числе персональные данные) указаны им добровольно;
                     - регистрационные данные (в том числе персональные данные) переданы Администрации сайта для реализации целей, указанных в настоящем Соглашении;
                     - регистрационные данные (в том числе персональные данные) являются правдивыми и актуальными на момент Регистрации в Сервисе;
                     - регистрационные данные (в том числе персональные данные) могут быть использованы Администрацией Сервиса в целях продвижения товаров и услуг, путем осуществления прямых контактов с Пользователем с помощью каналов связи (e-mail и sms-рассылки, звонков).
                     3. ПРЕДМЕТ ПОЛОЖЕНИЯ
                     3.1. Настоящее Положение регламентирует обязанности Администрации Сервиса по неразглашению персональных данных Пользователей Сервиса и установлению режима защиты данных, которые Пользователь предоставляет Администрации Сервиса в процессе использования Сервиса Пользователями, в том числе в процессе прохождения ими процедуры регистрации.
                     3.2. Настоящее Положение разработано в строгом соответствии с Федеральным Законом Российской Федерации № 152-ФЗ «О персональных данных» от 27.07.2006 года, а также другими нормативно-правовыми документами, которые регулируют порядок обработки персональных данных Пользователей в сети Интернет.
                     3.3. К персональным данным Пользователей, которые являются объектом настоящего Положения, относится:
                     3.3.1. Обязательные персональные данные, которые Пользователь добровольно и осознанно предоставляет о себе при Регистрации в Сервисе, необходимые в первую очередь для выполнения обязательств со стороны Администрации Сервиса.
                     3.3.2. Необязательные персональные данные, которые Пользователь добровольно и осознанно предоставляет о себе при Регистрации на Сервисе и/или при использовании Сервиса.
                     3.3.3. Обезличенные данные, автоматически получаемые Администрацией Сервиса в процессе нахождения Пользователя на любой странице Сервиса, при помощи установленного на устройстве Пользователя программного обеспечения: IP-адрес, Cookie, информация о браузере Пользователя (или иной программе, с помощью которой Пользователь осуществляет доступ к Сервису), время доступа, адреса запрашиваемых страниц и т.д.
                     3.3.4. Администрация Сервиса осуществляет сбор статистических данных об IP-адресах Пользователей. Данная информация используется с целью выявления и решения технических проблем.
                     3.4. Администрация Сервиса не несет ответственности за сведения, добровольно распространенные Пользователем в общедоступной форме.
                     4. ЦЕЛИ СБОРА ПЕРСОНАЛЬНЫХ ДАННЫХ
                     4.1. Администрация Сервиса оставляет за собой право использования любых персональных данных Пользователя, которые он передал в процессе использования Сервиса, в следующих целях:
                     4.1.1. для идентификации зарегистрированных Пользователей в Сервисе, с целью предоставления дальнейшей возможности использования функциональных возможностей Сервиса;
                     4.1.2. для возможности определения места нахождения Пользователя с целью обеспечения безопасности, предотвращения взломов и мошенничества;
                     4.1.3. для предоставления Пользователю информационных материалов, которые содержат описание порядка использования Сервиса;
                     4.1.4. для формирования обратной связи с Пользователем, посредством которой Пользователю предоставляется возможность общения с Администрацией Сервиса путем направления вопросов или иной информации через сформированные каналы обратной связи;
                     4.1.5. для предоставления Пользователю рекламных материалов Сервиса посредством каналов связи с обязательного разрешения Пользователя;
                     4.1.6. для предоставления Пользователю, посредством установленных каналов обратной связи, новостей касательно Сервиса и его обновлений;
                     4.1.7. для формирования учетной записи Пользователя, посредством которой Пользователю предоставляется возможность использования функционала Сервиса;
                     4.1.8. для использования Администрацией Сервиса обезличенных данных в статистических исследованиях;
                     4.1.9. для проверок достоверности переданных ранее Пользователем персональных данных и проверок на актуальность таких данных на день такой проверки;
                     4.1.10. для предоставления Пользователю необходимой технической поддержки в процессе использования им функционала Сервиса;
                     4.1.11. для получения отзывов от Пользователя о функционировании Сервиса с целью улучшения работы Сервиса, его элементов и т.д.;
                     4.1.12. для предоставления услуг по поиску и/или предложению товаров и/или сопутствующих услуг Пользователям Сервиса;
                     4.1.13. для предоставления иных услуг и выполнения иных обязательств, взятых на себя Администрацией Сервиса в настоящем Положении и договорах (публичных офертах) на оказание услуг посредством Сервиса.
                     5. ПОРЯДОК ОБРАБОТКИ ПЕРСОНАЛЬНЫХ ДАННЫХ
                     5.1. Любая обработка персональных данных Пользователя, которые он передал Администрации Сервиса в процессе использования Сервиса, осуществляется без какого-либо ограничения срока, любыми оговоренными в настоящем Положении и законодательстве РФ способами с использованием или без использования соответствующих средств автоматизации.
                     5.2. Пользователь принимает во внимание и соглашается с тем, что Администрация Сервиса оставляет за собой право передавать персональные данные Пользователя, которые были переданы им в процессе использования Сервиса, третьим лицам с целью выполнения обязательств, взятых на себе в рамках взаимоотношений между сторонами.
                     5.3. Пользователь принимает во внимание и соглашается с тем, что Администрация Сервиса может передать любые персональные данные, которые были ранее переданы ей Пользователем в процессе использования Сервиса, в случаях предусмотренных законодательством РФ и на основаниях, предусмотренных в законодательстве РФ уполномоченным на такие действия органам государственной власти.
                     5.4. Администрация Сервиса обязуется, в случае утраты и разглашения персональных данных Пользователя, которые были переданы ей Пользователем в процессе использования Сервиса, сообщить об этом Пользователю в кратчайшие сроки.
                     5.5. Обязательства по охране, защите и блокировке персональных данных, которые были переданы Пользователем в процессе использования Сервиса, выполняет Администрация Сервиса.
                     6. ОБЯЗАТЕЛЬСТВА СТОРОН
                     6.1. Администрация Сервиса обязуется совершать следующие действия:
                     6.1.1. совершать действия по обработке персональных данных, переданных Пользователем в процессе использования Сервиса, в строгом соответствии с условиями настоящего Положения, норм законодательства РФ, а также в соответствии с другими документами, которые регулируют взаимоотношения между Пользователем и Администрацией Сервиса и размещены на страницах Сервиса;
                     6.1.2. прилагать необходимый объем усилий для охраны, защиты персональных данных Пользователя, которые были переданы им в процессе использования Сервиса;
                     6.1.3. блокировать соответствующую учетную запись Пользователя, в случаях обращения такого Пользователя к Администрации Сервиса с заявлением о потере логина или/и пароля или о взломе учетной записи такого Пользователя, а также в ситуациях предусмотренных настоящим Положением или/и законодательством РФ;
                     6.1.4. использовать персональные данные Пользователя, которые он передал Администрации Сервиса в процессе использования Сервиса, исключительно в объеме и способом регламентированным настоящим Положением;
                     6.1.5. прекратить обработку, хранение и передачу персональных данных Пользователя по соответствующему обращению Пользователя. В таком случае учетная запись Пользователя подлежит блокированию со стороны Администрации Сервиса.
                     6.2. Пользователь обязуется совершать следующие действия:
                     6.2.1. предоставить Администрации Сервиса всю необходимую достоверную информацию, в том числе персональные данные, которые необходимы или могут быть необходимы Администрации Сервиса;
                     6.2.2. предоставить Администрации Сервиса информацию, в том числе персональные данные, в случае их изменений, для того, чтобы Администрация Сервиса могла выполнять обязательства, возложенные на нее настоящим Положением.
                     7. ОТВЕТСТВЕННОСТЬ СТОРОН
                     7.1. Ни в каком случае Администрация Сервиса не несет ответственности за убытки, причиненные разглашением персональных данных Пользователя, включая, но не ограничиваясь следующими случаями:
                     7.1.1. Персональные данные Пользователя стали публичными до разглашения персональной информации Пользователя Администрацией Сервиса.
                     7.1.2. Персональная информация была разглашена с разрешения Пользователя.
                     7.1.3. Внесения данных третьими лицами в Сервис, данные котором не принадлежат.
                     7.1.4. Персональная информация была получена от третьей стороны до момента ее получения Администрацией Сервиса от Пользователя.
                     8. РАЗРЕШЕНИЕ СПОРОВ
                     8.1. Все споры и разногласия, возникающие между Продавцом и Покупателем, разрешаются путем переговоров. Обращения Покупателя по поводу качества и доставки Товара принимаются в течение 24 часов с момента доставки Товара. Обращение обязательно должно содержать фотофиксацию Товара. Обращения, не соответствующие данным условиям, не подлежат рассмотрению.
                     8.2. До обращения в суд с иском по спорам, возникающим из отношений между Пользователем и Администрацией Сервиса, обязательным является предъявление письменного предложения о добровольном урегулировании спора.
                     8.3. Получатель претензии в течение 30 (тридцать) календарных дней со дня получения претензии, письменно уведомляет заявителя претензии о результатах рассмотрения претензии.
                     8.4. Претензионные письма направляются сторонами курьером, либо заказным почтовым отправлением с уведомлением о вручении последнего адресату по местонахождению сторон.
                     8.5. Не допускается направление сторонами претензионных писем иными способами.
                     8.6. При не достижении соглашения спор будет передан на рассмотрение в судебный орган по местонахождению Администрации Сервиса.
                     9. ФОРС-МАЖОР
                     9.1. Администрация Сервиса и Пользователь освобождаются от ответственности за полное или частичное неисполнение обязательств в случае, если неисполнение обязательств явилось следствием действий непреодолимой силы, а именно: пожара, наводнения, землетрясения, забастовки, войны, действий органов государственной власти или других независящих от Сторон обстоятельств.
                     9.2. Сторона, которая не может выполнить обязательства, должна своевременно, но не позднее 5 (пяти) календарных дней после наступления обстоятельств непреодолимой силы, известить другую сторону.
                     10. ИНЫЕ УСЛОВИЯ
                     10.1. Администрация Сервиса вправе в любое время с согласием или без согласия Пользователя внести изменения в настоящее Положение, при этом такие изменения вступают в силу с момента ее размещения на Сервисе, если иное не предусмотрено новой редакцией Положения.
                     10.2. Адрес электронной почты Администрации Сервиса для рассмотрения обращений Пользователей указан в реквизитах настоящего Положения.
                     10.3. Согласие Пользователя на обработку персональных данных действует до окончания использования услуг, предоставляемых Администрацией Сервиса посредством функционала Сервиса.
                     
                     РЕКВИЗИТЫ АДМИНИСТРАЦИИ СЕРВИСА
                     ИП Кутовенко Г.В.
                     УНП: 192343732
                     
                     Дата публикации: 10.09.2022

""").multilineTextAlignment(.leading)
                .padding()
                    .font(Font(uiFont: .fontLibrary(10, .uzSansRegular)))
                    .foregroundColor(.black)
            }
        }
    }
}

struct ConfidentialView_Previews: PreviewProvider {
    static var previews: some View {
        ConfidentialView()
    }
}
