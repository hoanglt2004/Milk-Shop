<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>CSS Debug Test Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Test CSS Loading -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" rel="stylesheet"
            id="css-bootstrap" />
        <link href="css/admin-bootstrap.css" rel="stylesheet" type="text/css" id="css-relative" />
        <link href="${pageContext.request.contextPath}/css/admin-bootstrap.css" rel="stylesheet" type="text/css"
            id="css-absolute" />

        <style>
            .debug-info {
                background: #f8f9fa;
                border: 1px solid #dee2e6;
                border-radius: 4px;
                padding: 15px;
                margin: 15px 0;
                font-family: monospace;
            }

            .status-ok {
                color: #28a745;
                font-weight: bold;
            }

            .status-error {
                color: #dc3545;
                font-weight: bold;
            }

            .test-card {
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                padding: 20px;
                margin: 20px 0;
                background: white;
            }
        </style>
    </head>

    <body>
        <div class="container-fluid">
            <h1>🔧 CSS Debug Test Page</h1>

            <div class="debug-info">
                <h3>Debug Information:</h3>
                <p><strong>Context Path:</strong>
                    <%= request.getContextPath() %>
                </p>
                <p><strong>Request URI:</strong>
                    <%= request.getRequestURI() %>
                </p>
                <p><strong>Server Name:</strong>
                    <%= request.getServerName() %>:<%= request.getServerPort() %>
                </p>
                <p><strong>Servlet Path:</strong>
                    <%= request.getServletPath() %>
                </p>
            </div>

            <div class="debug-info">
                <h3>CSS Path Tests:</h3>
                <p><strong>Relative CSS Path:</strong> css/admin-bootstrap.css</p>
                <p><strong>Absolute CSS Path:</strong> ${pageContext.request.contextPath}/css/admin-bootstrap.css</p>
                <p><strong>Full URL Test:</strong> <a href="${pageContext.request.contextPath}/css/admin-bootstrap.css"
                        target="_blank">Click to test CSS file</a></p>
            </div>

            <!-- Test Admin CSS Classes -->
            <div class="test-card">
                <h3>🎨 CSS Classes Test</h3>
                <p>Nếu bạn thấy styling đẹp ở các element dưới đây thì CSS đã load thành công:</p>

                <div class="sidebar"
                    style="position: relative; width: 200px; height: 100px; float: left; margin-right: 20px;">
                    <div style="padding: 10px;">Sidebar Test</div>
                </div>

                <div class="card" style="width: 300px; float: left;">
                    <div class="card-body">
                        <h4 class="text-primary">Card Test</h4>
                        <p class="text-muted">Đây là test card với admin CSS</p>
                        <button class="btn btn-primary">Button Test</button>
                    </div>
                </div>

                <div style="clear: both;"></div>
            </div>

            <div class="debug-info">
                <h3>JavaScript CSS Loading Test:</h3>
                <div id="css-status"></div>
            </div>
        </div>

        <script>
            // Test CSS loading bằng JavaScript
            function testCSSLoading() {
                const statusDiv = document.getElementById('css-status');
                const links = document.querySelectorAll('link[rel="stylesheet"]');

                let results = '<h4>CSS Loading Status:</h4>';

                links.forEach((link, index) => {
                    const href = link.getAttribute('href');
                    const id = link.getAttribute('id') || `css-${index}`;

                    // Test nếu CSS đã load
                    try {
                        if (link.sheet && link.sheet.cssRules) {
                            results += `<p class="status-ok">✅ ${href} - LOADED (${link.sheet.cssRules.length} rules)</p>`;
                        } else {
                            results += `<p class="status-error">❌ ${href} - FAILED TO LOAD</p>`;
                        }
                    } catch (e) {
                        results += `<p class="status-error">❌ ${href} - ERROR: ${e.message}</p>`;
                    }
                });

                statusDiv.innerHTML = results;
            }

            // Test sau khi page load
            window.addEventListener('load', function () {
                setTimeout(testCSSLoading, 1000);
            });
        </script>
    </body>

    </html>