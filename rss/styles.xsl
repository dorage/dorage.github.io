<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:atom="http://www.w3.org/2005/Atom">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>

	<xsl:template match="/">
		<html lang="ko">
			<head>
				<meta charset="utf-8"/>
				<meta name="viewport" content="width=device-width,initial-scale=1"/>
				<title><xsl:value-of select="/rss/channel/title"/> &#183; RSS</title>
				<style>
					:root {
						color-scheme: light dark;
						--bg: #fff;
						--fg: #1a1a1a;
						--muted: #6b6b6b;
						--line: #e5e5e5;
						--accent: #2337ff;
					}
					@media (prefers-color-scheme: dark) {
						:root {
							--bg: #16161a;
							--fg: #ededed;
							--muted: #9a9a9a;
							--line: #2c2c31;
							--accent: #8f9dff;
						}
					}
					* { box-sizing: border-box; }
					body {
						margin: 0;
						padding: 3rem 1.25rem 5rem;
						background: var(--bg);
						color: var(--fg);
						font-family: "Nanum Gothic Coding", ui-monospace, SFMono-Regular, Menlo, monospace;
						line-height: 1.7;
					}
					main { max-width: 44rem; margin: 0 auto; }
					a { color: var(--accent); }
					.note {
						border: 1px solid var(--line);
						border-radius: 8px;
						padding: 1rem 1.25rem;
						margin-bottom: 2.5rem;
						color: var(--muted);
						font-size: 0.9rem;
					}
					.note code {
						color: var(--fg);
						word-break: break-all;
					}
					h1 { font-size: 1.6rem; margin: 0 0 0.25rem; }
					.desc { color: var(--muted); margin: 0 0 0.75rem; }
					.home { font-size: 0.9rem; }
					ul { list-style: none; padding: 0; margin: 2.5rem 0 0; }
					li { padding: 1.25rem 0; border-top: 1px solid var(--line); }
					li h2 { font-size: 1.1rem; margin: 0 0 0.25rem; }
					li h2 a { text-decoration: none; }
					li h2 a:hover { text-decoration: underline; }
					time { display: block; color: var(--muted); font-size: 0.8rem; margin-bottom: 0.5rem; }
					li p { margin: 0; color: var(--muted); }
				</style>
			</head>
			<body>
				<main>
					<div class="note">
						이 페이지는 RSS 피드입니다. 주소를 복사해 RSS 리더에 넣으면 새 글을 구독할 수 있습니다.
						<br/>
						<code><xsl:value-of select="/rss/channel/atom:link/@href"/></code>
					</div>

					<h1><xsl:value-of select="/rss/channel/title"/></h1>
					<p class="desc"><xsl:value-of select="/rss/channel/description"/></p>
					<p class="home">
						<a>
							<xsl:attribute name="href"><xsl:value-of select="/rss/channel/link"/></xsl:attribute>
							블로그로 이동 &#8594;
						</a>
					</p>

					<ul>
						<xsl:for-each select="/rss/channel/item">
							<li>
								<h2>
									<a>
										<xsl:attribute name="href"><xsl:value-of select="link"/></xsl:attribute>
										<xsl:value-of select="title"/>
									</a>
								</h2>
								<time><xsl:value-of select="substring(pubDate, 1, 16)"/></time>
								<p><xsl:value-of select="description"/></p>
							</li>
						</xsl:for-each>
					</ul>
				</main>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
