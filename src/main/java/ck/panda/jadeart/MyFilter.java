package ck.panda.jadeart;

import java.io.IOException;
import java.util.Enumeration;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@WebFilter("/*")
public class MyFilter implements Filter {
    /** The base name for the resource bundle */
    private final static String BASE_NAME = "i18n/messages";

    /** The resource bundle for testing which resource bundle is available */
    private ResourceBundle bundle = null;

    /** Locale to be stored in the session */
    private Locale locale;

    /** The default locale we are using */
    private Locale defaultLocale = new Locale("en");

    /** The HTTP request, used to retrieve a session */
    private HttpServletRequest httpRequest = null;

    /** The HTTP session. The locale is stored in the session */
    private HttpSession session = null;

    public void init(FilterConfig arg0) throws ServletException {
    }


    /**
     * Filter all request to one of the web services.
     *
     * <p>
     * The following steps are executed here:
     * <ol>
     *      <li>Set the character encoding for the request to UTF-8</li>
     *      <li>Look for a request parameter <em>language</em> containing
     *          the user seleced locale to be used.</serli>
     *      <li>Look for a locale in the session.</li>
     *      <li>Try to find the best matching locale by matching them to
     *          available resource bundles, if we don't have a locale in
     *          the session.</li>
     *      <li>If there was a locale parameter, try to load that
     *          resource bundle.</li>
     * </ol>
     *
     * @param request
     *            ServletRequest object
     * @param response
     *            ServletResponse object
     *
     */
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain)
            throws IOException, ServletException {
        String requestedUri = ((HttpServletRequest)request).getRequestURI();
        System.out.println("URI" + requestedUri);
        String contentType = ((HttpServletRequest)request).getContentType();
        System.out.println("ContentType" + contentType);
        //((HttpServletRequest)request).getContentType().equals("text/html")
        if(!requestedUri.matches(".*(css|jpg|png|gif|js|woff)")) {
            System.out.println("URI" + requestedUri);
            // All data coming from the app is UTF-8
            request.setCharacterEncoding("UTF-8");

            // Retrieve the HTTP session
            httpRequest = (HttpServletRequest) request;
            session = httpRequest.getSession();

            Cookie[] cookies = httpRequest.getCookies();

            // Default Language
            String languageString = "en";
            // Get the selected language from cookie
            if(cookies == null){
                this.findBundle();
            }
            else {
                for (Cookie cookie : cookies) {
                    if (cookie != null) {
                        if ("ls.language".equals(cookie.getName())) {
                            languageString = cookie.getValue();
                        }
                    }
                }
            }

            // A locale can be manually selected by passing a request paramater
            // with the variable name language to the filter containing a
            // ISO-639 two letter country code
            String languageCode = languageString;
            // Check if we have a locale in the session
            this.locale = (Locale) session.getAttribute("myLocale");

            // If no locale is defined in the session, automatically find the best
            // match
            if (this.locale == null) {
                this.findBundle();
                this.locale = (Locale) session.getAttribute("myLocale");
            } else {
                System.out.println("else Checking for localesss " + this.locale);
            }

            System.out.println("Checking for localecode " + languageCode);
            System.out.println("Checking for locale " + this.locale);
            // Check if user manually selected a new language for the app
            if (languageCode != null && languageCode.length() == 2
                    && languageCode != this.locale.getLanguage()) {
                this.setNewLocale(languageCode);
            }
            request.setAttribute("language", this.locale);
        }
        filterChain.doFilter(request, response);
    }

    public void destroy() {
    }


    /**
     * Set a new locale based on a String containing the language code for the
     * new locale.
     *
     * @param languageCode
     *            The ISO-639 language code for the new locale Creates a new
     *            locale based on the language code send to the filter. Then
     *            tries to load the ResourceBundle for that language. If the
     *            ResourceBundle can be loaded the Locale in the session is
     *            updated to the new one.
     *
     */
    private void setNewLocale(String languageCode) {
        languageCode = languageCode.toLowerCase();
        // get a bundle and see whether it has a good locale
        ClassLoader cl = Thread.currentThread().getContextClassLoader();
        Locale newLocale = new Locale(languageCode);
        bundle = ResourceBundle.getBundle(MyFilter.BASE_NAME, newLocale, cl);
        String testedLang = bundle.getLocale().getLanguage();
        if (testedLang.equals(languageCode)) {
            // This is the locale we have been looking for
            session.setAttribute("myLocale", bundle.getLocale());
            System.out.println("Switching to language " + bundle.getLocale() + " / "
                    + bundle.getLocale().getDisplayLanguage());
        } else if (languageCode.equals(defaultLocale.getLanguage())) {
            // This is the default locale right now
            session.setAttribute("myLocale", bundle.getLocale());
            this.locale = bundle.getLocale();
            System.out.println("Using default locale " + defaultLocale);
        } else {
            // Requested locale not found, change nothing
            System.out.println("Invalid locale or missing resource bundle for manually selected locale "
                            + languageCode);
        }
    }

    /**
     * Locates and prepares a ResourceBundle for use within LZProject. The
     * first preferred locale available that matches at least on basis of
     * language is used.
     *
     * Once a preferred locale has been determined for the given bundle name,
     * the locale is cached in the user's session, so that the above computation
     * can be avoided the next time the user requests a page with this bundle.
     */
    private void findBundle() {
        // if we now have a locale, grab the resource bundle
        ClassLoader cl = Thread.currentThread().getContextClassLoader();
        if (locale != null) {
            bundle = ResourceBundle.getBundle(MyFilter.BASE_NAME, locale, cl);
            System.out.println("Default locale with base " + MyFilter.BASE_NAME
                    + " found: " + locale);
        }

        // attempt to load the bundle and compute the locale by looping through
        // the browser's preferred locales; cache the final locale for future
        // use
        else {
            /**Enumeration localeEnumerator = httpRequest.getLocales();
            while (localeEnumerator.hasMoreElements()) {
                locale = (Locale) localeEnumerator.nextElement();
                System.out.println("Checking for localesssss " + locale.getLanguage());
                System.out.println("####################### ");
                System.out.println("Checking for cl " + cl);

                // get a bundle and see whether it has a good locale
                ResourceBundle testBundle = ResourceBundle.getBundle(
                        MyFilter.BASE_NAME, locale, cl);
                String language = testBundle.getLocale().getLanguage();
                String country = testBundle.getLocale().getCountry();

                // if the requested locale isn't available, the above call will
                // return a bundle with a locale for the same language, or will
                // return the default locale, so we need to compare the locale
                // of the bundle we got back with the one we asked for
                if (testBundle.getLocale().equals(locale)) {
                    // exactly what we were looking for - stop here and use this
                    bundle = testBundle;
                    break;
                } else if (locale.getLanguage().equals(language)) {
                    // the language matches; see if the country matches as well
                    if (locale.getCountry().equals(country)) {
                        // keep looking but this is a good option. it only gets
                        // better if the variant matches too! (note: we will
                        // only
                        // get to this statement if a variant has been provided)
                        bundle = testBundle;
                        continue;
                    } else {
                        // if we don't already have a candidate, this is a good
                        // one otherwise, don't change it because the current
                        // candidate might match the country but not the variant
                        if (bundle == null) {
                            bundle = testBundle;
                        }
                        continue;
                    }
                } else {
                    System.out.println("Locale " + locale + " not available");
                }
            } */
            // end while loop / stepping through localeEnumerator

            // Bundle should not be null here, but just to make sure we have one,
            // select the default one.
            if (bundle == null) {
                bundle = ResourceBundle.getBundle(MyFilter.BASE_NAME);
                //locale = bundle.getLocale();
            }
            System.out.println("Else part");
            this.setNewLocale("en");

            // If we don't have a locale in the session, store it now
//            if (session.getAttribute("myLocale") == null) {
//                session.setAttribute("myLocale", bundle.getLocale());
//            }
        }

    }
}
