<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <html lang="en">
            <head>
                <title>XML creado</title>
                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous"/>
                <link href="custom.css" rel="stylesheet"/>
            </head>
            <body>
                <div class="container">
                    <h1 align="center">XML creado</h1>
                    <h4>Ligas:</h4>
                    <table class="table">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">Nombre</th>
                                <th scope="col">Presidente</th>
                                <th scope="col">Pais</th>
                                <th scope="col">Equipos</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:apply-templates select="ligas/liga"/>
                        </tbody>
                    </table>
                    <br/>
                    <br/>
                    <h4>Equipos:</h4>
                    <table class="table">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">Siglas</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Presupuesto</th>
                                <th scope="col">Total de Jugadores</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:apply-templates select="ligas/liga/equipos/equipo" mode="tabla"/>
                        </tbody>
                    </table>
                </div>

                <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
            </body></html>
    </xsl:template>


    <xsl:template match="liga">
        <tr>
            <th><xsl:value-of select="nombre" /></th>
            <td><xsl:value-of select="presidente" /></td>
            <td><xsl:value-of select="pais"/></td>
            <td><strong class="text-dark"><xsl:apply-templates select="equipos/equipo" mode="siglas"/></strong></td>
        </tr>
    </xsl:template>

    <xsl:template match="equipo" mode="siglas">
        <xsl:value-of select="@siglas" />
        <xsl:choose>
            <xsl:when test="position() != last()">
                <xsl:text>, </xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="equipo" mode="tabla">
        <tr class="table-warning">
            <th><xsl:value-of select="@siglas" /></th>
            <th><xsl:value-of select="nombre" /></th>
            <th><xsl:value-of select="@presupuesto" /> EUR</th>
            <th><xsl:value-of select="total_jugadores" /></th>
        </tr>
    </xsl:template>
</xsl:stylesheet>