import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// #enddocregion platform_imports

void main() => runApp(const MaterialApp(home: AvisoPrivacidadScreen()));

Color bgColor = Colors.red.shade200;

const String kLogExamplePage = '''
<div style="margin: 15px">
    <br>
    <div class="fw-light">
        <p style="text-align: left;">Sastrer&iacute;a &ldquo;Los pajaritos&rdquo;, con domicilio en calle Cerrada Digna
            Ochoa, EXT.5, Colonia Coacuilco, Ciudad Huejutla, municipio o delegaci&oacute;n Huejutla de Reyes, c.p.
            43000, en la entidad de Hidalgo, pa&iacute;s M&eacute;xico, y portal de internet
            www.SastreriaLospajaritos.com.mx, es el responsable del uso y protecci&oacute;n de sus datos personales, y
            al respecto le informamos lo siguiente:</p>
        <p style="text-align: left;"><br></p>
        <p><strong>&iquest;Para qu&eacute; fines utilizaremos sus datos personales?&nbsp;</strong></p>
        <p>De manera adicional, utilizaremos su informaci&oacute;n personal para las siguientes finalidades secundarias
            que no son necesarias para el servicio solicitado, pero que nos permiten y facilitan brindarle una mejor
            atenci&oacute;n:</p>
        <p>&bull; &nbsp; &nbsp;Para fines publicitarios</p>
        <p>&bull; &nbsp; &nbsp;Mercadotecnia o publicitaria</p>
        <p>&bull; &nbsp; &nbsp;Prospecci&oacute;n comercial</p>
        <p>En caso de que no desee que sus datos personales se utilicen para estos fines secundarios, ind&iacute;quelo a
            continuaci&oacute;n:</p>
        <p>No consiento que mis datos personales se utilicen para los siguientes fines:</p>
        <p>[ &nbsp;] Para fines publicitarios</p>
        <p>[ &nbsp;] Mercadotecnia o publicitaria&nbsp;</p>
        <p>[ &nbsp;] Prospecci&oacute;n comercial&nbsp;</p>
        <p>La negativa para el uso de sus datos personales para estas finalidades no podr&aacute; ser un motivo para que
            le neguemos los servicios y productos que solicita o contrata con nosotros.</p>
        <p><br></p>
        <p><strong>&iquest;Qu&eacute; datos personales utilizaremos para estos fines?&nbsp;</strong></p>
        <p>Para llevar a cabo las finalidades descritas en el presente aviso de privacidad, utilizaremos los siguientes
            datos personales:</p>
        <p>&bull; &nbsp; &nbsp;Datos de identificaci&oacute;n</p>
        <p>&bull; &nbsp; &nbsp;Datos de contacto</p>
        <p><br></p>
        <p><strong>&iquest;C&oacute;mo puede acceder, rectificar o cancelar sus datos personales, u oponerse a su
                uso?&nbsp;</strong></p>
        <p>Usted tiene derecho a conocer qu&eacute; datos personales tenemos de usted, para qu&eacute; los utilizamos y
            las condiciones del uso que les damos (Acceso). Asimismo, es su derecho solicitar la correcci&oacute;n de su
            informaci&oacute;n personal en caso de que est&eacute; desactualizada, sea inexacta o incompleta
            (Rectificaci&oacute;n); que la eliminemos de nuestros registros o bases de datos cuando considere que la
            misma no est&aacute; siendo utilizada adecuadamente (Cancelaci&oacute;n); as&iacute; como oponerse al uso de
            sus datos personales para fines espec&iacute;ficos (Oposici&oacute;n). Estos derechos se conocen como
            derechos ARCO.</p>
        <p>Para el ejercicio de cualquiera de los derechos ARCO, usted deber&aacute; presentar la solicitud respectiva a
            trav&eacute;s del siguiente medio:&nbsp;</p>
        <p>Puede comunicarse a trav&eacute;s del n&uacute;mero de tel&eacute;fono (771) 352 3786 o al correo sastrerialospajaritos@gmail.com">sastrerialospajaritos@gmail.com
        </p>
        <p>Para conocer el procedimiento y requisitos para el ejercicio de los derechos ARCO, ponemos a su
            disposici&oacute;n el siguiente medio:</p>
        <p>Una p&aacute;gina de internet</p>
        <p>Los datos de contacto de la persona o departamento de datos personales, que est&aacute; a cargo de dar
            tr&aacute;mite a las solicitudes de derechos ARCO, son los siguientes:&nbsp;</p>
        <p>a) Nombre de la persona o departamento de datos personales: Gustavo Adolfo Trejo Cruz</p>
        <p>b) Domicilio: calle Los Otates, colonia Conocido, ciudad Los Otates, municipio o delegaci&oacute;n Huejutla
            de Reyes, c.p. 43003, en la entidad de Hidalgo, pa&iacute;s M&eacute;xico</p>
        <p>c) Correo electr&oacute;nico: gustavoadolfotrejocruz@outlook.com</p>
        <p>d) N&uacute;mero telef&oacute;nico: (771) 267 7542</p>
        <p>Usted puede revocar su consentimiento para el uso de sus datos personales</p>
        <p>Usted puede revocar el consentimiento que, en su caso, nos haya otorgado para el tratamiento de sus datos
            personales. Sin embargo, es importante que tenga en cuenta que no en todos los casos podremos atender su
            solicitud o concluir el uso de forma inmediata, ya que es posible que por alguna obligaci&oacute;n legal
            requiramos seguir tratando sus datos personales. Asimismo, usted deber&aacute; considerar que, para ciertos
            fines, la revocaci&oacute;n de su consentimiento implicar&aacute; que no le podamos seguir prestando el
            servicio que nos solicit&oacute;, o la conclusi&oacute;n de su relaci&oacute;n con nosotros.</p>
        <p>Para revocar su consentimiento deber&aacute; presentar su solicitud a trav&eacute;s del siguiente
            medio:&nbsp;</p>
        <p>Un correo electr&oacute;nico&nbsp;</p>
        <p>Con relaci&oacute;n al procedimiento y requisitos para la revocaci&oacute;n de su consentimiento, le
            informamos lo siguiente:&nbsp;</p>
        <p>a) &iquest;A trav&eacute;s de qu&eacute; medios pueden acreditar su identidad el titular y, en su caso, su
            representante, as&iacute; como la personalidad este &uacute;ltimo?</p>
        <p>A trav&eacute;s de una frase</p>
        <p>b) &iquest;Qu&eacute; informaci&oacute;n y/o documentaci&oacute;n deber&aacute; contener la solicitud?</p>
        <p>Identificaci&oacute;n Oficial</p>
        <p>c) &iquest;En cu&aacute;ntos d&iacute;as le daremos respuesta a su solicitud?</p>
        <p>1 d&iacute;a</p>
        <p>d) &iquest;Por qu&eacute; medio le comunicaremos la respuesta a su solicitud?</p>
        <p>Correo electr&oacute;nico</p>
        <p><br></p>
        <p><strong>&iquest;C&oacute;mo puede limitar el uso o divulgaci&oacute;n de su informaci&oacute;n
                personal?&nbsp;</strong></p>
        <p>Con objeto de que usted pueda limitar el uso y divulgaci&oacute;n de su informaci&oacute;n personal, le
            ofrecemos los siguientes medios:&nbsp;</p>
        <p>A trav&eacute;s del sitio de internet</p>
        <p>Asimismo, usted se podr&aacute; inscribir a los siguientes registros, en caso de que no desee obtener
            publicidad de nuestra parte:&nbsp;</p>
        <p>Registro P&uacute;blico para Evitar Publicidad, para m&aacute;s informaci&oacute;n consulte el portal de
            internet de la PROFECO</p>
        <p>Registro P&uacute;blico de Usuarios, para mayor informaci&oacute;n consulte el portal de internet de la
            CONDUSEF</p>
        <p>El uso de tecnolog&iacute;as de rastreo en nuestro portal de internet</p>
        <p>Le informamos que en nuestra p&aacute;gina de internet utilizamos cookies, web beacons u otras
            tecnolog&iacute;as, a trav&eacute;s de las cuales es posible monitorear su comportamiento como usuario de
            internet, as&iacute; como brindarle un mejor servicio y experiencia al navegar en nuestra p&aacute;gina. Los
            datos personales que recabamos a trav&eacute;s de estas tecnolog&iacute;as, los utilizaremos para los
            siguientes fines:</p>
        <p>Para fines publicitarios y optimizaci&oacute;n de la experiencia en el sitio web a trav&eacute;s de sus
            distintas presentaciones</p>
        <p>Los datos personales que obtenemos de estas tecnolog&iacute;as de rastreo son los siguientes:</p>
        <p>Identificadores, nombre de usuario y contrase&ntilde;as de una sesi&oacute;n</p>
        <p>Idioma preferido por el usuario</p>
        <p>Regi&oacute;n en la que se encuentra el usuario</p>
        <p>Tipo de navegador del usuario</p>
        <p>Estas tecnolog&iacute;as podr&aacute;n deshabilitarse siguiendo los siguientes pasos: Deber&aacute; hacer
            clic en el bot&oacute;n Deserto a enviar los datos requeridos (Puede que la experiencia en la
            navegaci&oacute;n se vea afectada).</p>
        <p><br></p>
        <p><strong>&iquest;C&oacute;mo puede conocer los cambios en este aviso de privacidad?</strong></p>
        <p>El presente aviso de privacidad puede sufrir modificaciones, cambios o actualizaciones derivadas de nuevos
            requerimientos legales; de nuestras propias necesidades por los productos o servicios que ofrecemos; de
            nuestras pr&aacute;cticas de privacidad; de cambios en nuestro modelo de negocio, o por otras causas.</p>
        <p>Nos comprometemos a mantenerlo informado sobre los cambios que pueda sufrir el presente aviso de privacidad,
            a trav&eacute;s de: Correo electr&oacute;nico y un banner en la p&aacute;gina web.</p>
        <p>El procedimiento a trav&eacute;s del cual se llevar&aacute;n a cabo las notificaciones sobre cambios o
            actualizaciones al presente aviso de privacidad es el siguiente:&nbsp;</p>
        <p>Se enviar&aacute; un correo electr&oacute;nico a todos los que se hayan registrado en el sitio y se
            notificar&aacute; de los cambios en caso de haber accedido a la p&aacute;gina como un usuario registrado</p>
        <p>Su consentimiento para el tratamiento de sus datos personales&nbsp;</p>
        <p>Consiento que mis datos personales sean tratados de conformidad con los t&eacute;rminos y condiciones
            informados en el presente aviso de privacidad.[ &nbsp;]&nbsp;</p>
        <p>&nbsp;</p>
        <p><br></p>
        <p style="text-align: right;"><strong>NOTA:</strong> ESTE AVISO DE PRIVACIDAD OBEDECE A FINES MERAMENTE
            EDUCATIVOS</p>
        <p style="text-align: right;"><strong>&Uacute;ltima actualizaci&oacute;n: 21/09/2022</strong></p>
        <br><br>
    </div>
</div>
''';

class AvisoPrivacidadScreen extends StatefulWidget {
  const AvisoPrivacidadScreen({super.key});

  @override
  State<AvisoPrivacidadScreen> createState() => _AvisoPrivacidadScreenState();
}

class _AvisoPrivacidadScreenState extends State<AvisoPrivacidadScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      // ..loadRequest(Uri.parse('https://flutter.dev'))
      ..loadHtmlString(kLogExamplePage);

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white60,
        title: const Text(
          "Aviso de privacidad",
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: bgColor,
          ),
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
