
package pkg;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the pkg package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

    private final static QName _Hello_QNAME = new QName("http://webServices/", "hello");
    private final static QName _HelloResponse_QNAME = new QName("http://webServices/", "helloResponse");
    private final static QName _IniciaSesion_QNAME = new QName("http://webServices/", "iniciaSesion");
    private final static QName _IniciaSesionResponse_QNAME = new QName("http://webServices/", "iniciaSesionResponse");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: pkg
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link Hello }
     * 
     */
    public Hello createHello() {
        return new Hello();
    }

    /**
     * Create an instance of {@link HelloResponse }
     * 
     */
    public HelloResponse createHelloResponse() {
        return new HelloResponse();
    }

    /**
     * Create an instance of {@link IniciaSesion }
     * 
     */
    public IniciaSesion createIniciaSesion() {
        return new IniciaSesion();
    }

    /**
     * Create an instance of {@link IniciaSesionResponse }
     * 
     */
    public IniciaSesionResponse createIniciaSesionResponse() {
        return new IniciaSesionResponse();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link Hello }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://webServices/", name = "hello")
    public JAXBElement<Hello> createHello(Hello value) {
        return new JAXBElement<Hello>(_Hello_QNAME, Hello.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link HelloResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://webServices/", name = "helloResponse")
    public JAXBElement<HelloResponse> createHelloResponse(HelloResponse value) {
        return new JAXBElement<HelloResponse>(_HelloResponse_QNAME, HelloResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link IniciaSesion }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://webServices/", name = "iniciaSesion")
    public JAXBElement<IniciaSesion> createIniciaSesion(IniciaSesion value) {
        return new JAXBElement<IniciaSesion>(_IniciaSesion_QNAME, IniciaSesion.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link IniciaSesionResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://webServices/", name = "iniciaSesionResponse")
    public JAXBElement<IniciaSesionResponse> createIniciaSesionResponse(IniciaSesionResponse value) {
        return new JAXBElement<IniciaSesionResponse>(_IniciaSesionResponse_QNAME, IniciaSesionResponse.class, null, value);
    }

}
